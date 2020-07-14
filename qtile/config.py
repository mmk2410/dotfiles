# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

mod = "mod4"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

    # Move windows up and down in current stack
    Key([mod, "control"], "j", lazy.layout.shuffle_down()),
    Key([mod, "control"], "k", lazy.layout.shuffle_up()),

    # Increase and decrease window size
    Key([mod, "control"], "l", lazy.layout.increase_ratio()),
    Key([mod, "control"], "h", lazy.layout.decrease_ratio()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("es")), # es = emacsclient
    Key([mod], "t", lazy.spawn("alacritty -e /usr/bin/fish")),
    Key([mod, "shift"], "t", lazy.spawn("alacritty")),
    Key([mod], "b", lazy.spawn("nyxt")),
    Key([mod, "shift"], "b", lazy.spawn("firefox-developer-edition")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawn("rofi -show run")),
    Key([mod, "shift"], "r", lazy.spawncmd()),
]

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layout_defaults = dict(
    margin=10,
    border_width=3,
    border_focus="#d65d0e",
    border_normal="#928374",
)

layouts = [
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(,)
    layout.Matrix(),
    layout.MonadTall(),
    layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
]

widget_defaults = dict(
    font='Hermit',
    fontsize=12,
    padding=3,
    foreground="3c3836",
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    active="3c3836",
                    inactive="928374",
                    this_screen_border="458588",
                    urgent_border="cc241d",
                    urgent_text="cc241d"
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Notify(),
                widget.TextBox(
                    text='🞀',
                    fontsize="35",
                    foreground="689d6a",
                    padding=-2,
                ),
                widget.CurrentLayout(
                    background="689d6a",
                ),
                widget.TextBox(
                    text='🞀',
                    fontsize="35",
                    foreground="b16268",
                    background="689d6a",
                    padding=-2,
                ),
                widget.Volume(
                    background="b16268"
                ),
                widget.TextBox(
                    text='🞀',
                    fontsize="35",
                    foreground="458588",
                    background="b16268",
                    padding=-2,
                ),
                widget.Battery(
                    background="458588",
                    format='{char} {percent:2.0%} {hour:d}:{min:02d}',
                ),
                widget.TextBox(
                    text='🞀',
                    fontsize="35",
                    foreground="d79921",
                    background="458588",
                    padding=-2,
                ),
                widget.Backlight(
                    backlight_name="intel_backlight",
                    background="d79921"
                ),
                widget.TextBox(
                    text='🞀',
                    fontsize="35",
                    foreground="98971a",
                    background="d79921",
                    padding=-2,
                ),
                widget.Clock(
                    format='%Y-%m-%d %H:%M',
                    background="98971a",
                ),
                widget.Systray(),
            ],
            24,
            background="#fbf1c7",
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def start_once():
    """Run after qtile is started"""
    import os
    import subprocess

    autostart_file = os.path.expanduser('~/.config/qtile/startup.sh')
    subprocess.call([autostart_file])
