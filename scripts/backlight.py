#!/usr/bin/env python3

##############################################################################
# backlight.py -- A script for setting the backlight brightness using sysfs. #
# 2021 © Marcel Kapfer <opensource@mmk2410.org>                              #
# Licensed unter the MIT/Expat License                                       #
#                                                                            #
# It is expected that the running user has permission to change the relevant #
# sysfs file. See https://wiki.archlinux.org/title/Backlight#ACPI and the    #
# related "Discussion" wiki page on how to grant users the necessary right   #
##############################################################################

import sys

SYS_DIR = "/sys/class/backlight/"
GRAPHICS_CARD = "intel_backlight"
ACTUAL_BRIGHTNESS_FILE = "/actual_brightness"
MAX_BRIGHTNESS_FILE = "/max_brightness"
BRIGHTNESS_FILE = "/brightness"

def __read_file_as_int(path: str, function: str) -> int:
    """Read the value at the given `path` as integer.

    It is expected that the value in te file can be casted to an integer.

    Parameters
    ----------
    path : str
        Path to the file to read.
    function : str
        Information about the reason for writing the file. Used only for better error messages.

    Returns
    -------
    int
        Value read at the file at `path`.
    """

    try:
        with open(path, "r") as f:
            value = f.readline()
    except FileNotFoundError:
        print("[ERROR] Could not read {}. File {} not found.".format(function, path))
        sys.exit(2)
    except PermissionError:
        print("[ERROR] Could not read {}. Permission to read {} denied.".format(function, path))
        sys.exit(3)
    except IsADirectoryError:
        print("[ERROR] Could not read {}. {} is a directory.".format(function, path))
        sys.exit(4)

    try:
        value = int(value.strip())
    except ValueError:
        print("[ERROR] Could not parse {}.".format(function))
        sys.exit(1)

    return value


def __write_int_as_file(path: str, value: int, function: str) -> None:
    """Write the given integer `value` to the given `path`.

    This functions *overwrites* the file at `path`.

    Parameters
    ----------
    path : str
        Path to the file to write.
    value : int
        Value to write the file at `path`.
    function : str
        Information about the reason for writing the file. Used only for better error messages.
    """

    try:
        with open(path, "w") as f:
            print(value, file=f)
    except FileNotFoundError:
        print("[ERROR] Could not write {}. File {} not found".format(function, path))
        sys.exit(2)
    except PermissionError:
        print("[ERROR] Could not write {}. Permission to write {} denied.".format(function, path))
        sys.exit(3)
    except IsADirectoryError:
        print("[ERROR] Could not write {}. {} is a directory.".format(function, path))
        sys.exit(4)


def actual_brightness() -> int:
    """Get actual brightness value using sysfs.

    Read the actual brightness value from the corresponding file in sysfs.

    Returns
    -------
    int
        Actual brightness value.
    """

    path = SYS_DIR + GRAPHICS_CARD + ACTUAL_BRIGHTNESS_FILE
    return __read_file_as_int(path, "actual brightness")


def max_brightness() -> int:
    """Get maximum brightness value using sysfs.

    Read the maximum brightness value from the corresponding file in sysfs.

    Returns
    -------
    int
        Maximum brightness value.
    """

    path = SYS_DIR + GRAPHICS_CARD + MAX_BRIGHTNESS_FILE
    return __read_file_as_int(path, "maximal brightness")


def set_brightness(value: int) -> None:
    """Set a new brightness value using sysfs.
    
    Set the given brightness `value` by writing the the corresponding file in sysfs.

    Parameters
    ----------
    value:
        New brightness value.
    """

    path = SYS_DIR + GRAPHICS_CARD + BRIGHTNESS_FILE
    __write_int_as_file(path, value, "brightness")


def safe_set_brightness(new_brightness: int, max_brightness_value: int) -> None:
    """Set new brightness with obaying safety.

    Set a new brightness value using `set_brightness` by checking the value for some pitfalls.
    At the lower end the functions does not allow a brightness value lower than 5% of the maximum brightness.
    At the upper end the functions does not allow a brightness value higher than 100% of the maximum brightness.

    Parameters
    ----------
    new_brightness : int
        Value to set as brightness.
    max_brightness_value : int
        Maximum brightness value.
    """

    min_brightness_value = int(0.05 * max_brightness_value)

    if new_brightness < min_brightness_value:
        new_brightness = min_brightness_value
    elif new_brightness > max_brightness_value:
        new_brightness = max_brightness_value

    set_brightness(new_brightness)


def calc_brightness(value: float, actual_brightness_value: int, max_brightness_value: int, function: str) -> int:
    """Calculate brightness value based on actual and maximal brightness.

    The function calculates a brightness value using the `function` string and the `value` as a percentage.
    If `function` is empty the new brightness is the the `value` percentage of the maximum brightness.
    If `function` is + or - then the `value` percentage of the maximum brightness is added/subtracted from the actual brightness.

    Parameters
    ----------
    value : float
        The wanted change as a percentage.
    actual_brightness_value : int
        Value of the actual brightness.
    max_brightness_value : int
        Value of the maximum brightness.
    function : str
        Either "+" for addition to actual brightness, "-" for substraction of actual brightness or "" for relative to maximum brightness.

    Returns
    -------
    int
        Calculated brightness value.
    """

    if function == "+":
        new_brightness = actual_brightness_value + int(value * max_brightness_value)
    elif function == "-":
        new_brightness = actual_brightness_value - int(value * max_brightness_value)
    else:
        new_brightness = int(value * max_brightness_value)

    return new_brightness


def parse_arg(arg: str) -> (int, str):
    """Parse argument and return value and modifier.

    It is expected that the passed argument is the unaltered CLI argument of the form [+/-]NUMBER%.
    The function will check the format and raise a `ValueError` if it is not compatible.

    Parameters
    ----------
    arg : str
        String to parse

    Returns
    -------
    int
        Parsed value
    mod
        Parsed modifier, either +, - or an empty string.

    Raises
    ------
    ValueError
        If given argument has not the required format.
    """

    if len(arg) < 2 or len(arg) > 5:
        raise ValueError("Wrong format. Expected lenght between 2 and 5 characters")

    if arg[-1] != "%":
        raise ValueError("Wrong format. Expected '%' at the end.")
    
    mod = arg[0]
    number_start_index = 0
    if mod == "+" or mod == "-":
        number_start_index = 1
    else:
        try:
            int(mod)
        except ValueError:
            raise ValueError("Wrong format. Modifier neither +/- nor value of type integer.")
        # Set modifier to empty string to return a halfway meaningful value.
        mod = ""
    
    try:
        value = 0.01 * int(arg[number_start_index:-1])
    except ValueError:
        raise ValueError("Wrong format. Supplied value not a integer.")

    return value, mod


def print_help() -> None:
    """Print help on using this script."""
    print("Usage:")
    print("backlight.py [+/-]NUMBER%")
    print("  +: Increase brightness by NUMBER%")
    print("  -: Decrease brightness by NUMBER%")
    print("   : Set brightness to NUMBER%")


def main():
    """Main entry point."""
    if len(sys.argv) != 2:
        print("[ERROR] Unexpected amount of arguments.")
        print_help()
        sys.exit(5)

    try:
        value, mod = parse_arg(sys.argv[1])
    except ValueError:
        print("[ERROR] Malformed argument.")
        print_help()
        sys.exit(6)

    actual_brightness_value = actual_brightness()
    max_brightness_value = max_brightness()
    new_brightness = calc_brightness(value, actual_brightness_value, max_brightness_value, mod)
    safe_set_brightness(new_brightness, max_brightness_value)

if __name__ == "__main__":
    main()
