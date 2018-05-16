# dotfiles

My configuration files for various programs.

## Installing

To link the files to the correct places run

```
./install.fish
```

Make sure you have [fish](https://fishshell.com) installed.

## How it works

The script takes the directories in `dirs.list` and creats them (if they don't
exist). After that it runs over `links.list` and takes the first path as source
(appending ~/dotfiles) and the path after the space as the target (appending
only `~/`).
