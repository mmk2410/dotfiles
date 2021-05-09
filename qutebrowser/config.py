# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
config.load_autoconfig()

# Require a confirmation before quitting the application.
# Type: ConfirmQuit
# Valid values:
#   - always: Always show a confirmation.
#   - multiple-tabs: Show a confirmation if multiple tabs are opened.
#   - downloads: Show a confirmation if downloads are running
#   - never: Never show a confirmation.
c.confirm_quit = ['always']

# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

# Automatically start playing `<video>` elements. Note: On Qt < 5.11,
# this option needs a restart and does not support URL patterns.
# Type: Bool
c.content.autoplay = False

# Allow websites to request geolocations.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.geolocation = False

# Value to send in the `Accept-Language` header. Note that the value
# read from JavaScript is always the global value.
# Type: String
c.content.headers.accept_language = 'en-US,en,de,de-DE;q=0.9'

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value.
# Type: FormatString
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value.
# Type: FormatString
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value.
# Type: FormatString
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value.
# Type: FormatString
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'chrome-devtools://*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow pdf.js to view PDF files in the browser. Note that the files can
# still be downloaded by clicking the download button in the pdf.js
# viewer.
# Type: Bool
c.content.pdfjs = False

# Height (in pixels or as percentage of the window) of the completion.
# Type: PercOrInt
c.completion.height = '30%'

# Shrink the completion to be smaller than the configured size if there
# are no scrollbars.
# Type: Bool
c.completion.shrink = True

# Directory to save downloads to. If unset, a sensible OS-specific
# default is used.
# Type: Directory
c.downloads.location.directory = '/tmp/'

# Padding (in pixels) around text for tabs.
# Type: Padding
c.tabs.padding = {'bottom': 3, 'left': 5, 'right': 5, 'top': 3}

# Position of the tab bar.
# Type: Position
# Valid values:
#   - top
#   - bottom
#   - left
#   - right
c.tabs.position = 'left'

# Width (in pixels or as percentage of the window) of the tab bar if
# it's vertical.
# Type: PercOrInt
c.tabs.width = '14%'

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
# Type: List of QtColor, or QtColor
c.colors.completion.fg = '#3c3836'

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = '#fbf1c7'

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = '#fbf1c7'

# Foreground color of completion widget category headers.
# Type: QtColor
c.colors.completion.category.fg = '#3c3836'

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = '#ebdbb2'

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.top = '#ebdbb2'

# Bottom border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.bottom = '#ebdbb2'

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = '#3c3836'

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = '#ebdbb2'

# Top border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.top = '#ebdbb2'

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = '#ebdbb2'

# Foreground color of the matched text in the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.match.fg = '#458588'

# Foreground color of the matched text in the completion.
# Type: QtColor
c.colors.completion.match.fg = '#458588'

# Color of the scrollbar handle in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.fg = '#3c3836'

# Color of the scrollbar in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.bg = '#fbf1c7'

# Background color of the context menu. If set to null, the Qt default
# is used.
# Type: QssColor
c.colors.contextmenu.menu.bg = '#fbf1c7'

# Foreground color of the context menu. If set to null, the Qt default
# is used.
# Type: QssColor
c.colors.contextmenu.menu.fg = '#3c3836'

# Background color of the context menu's selected item. If set to null,
# the Qt default is used.
# Type: QssColor
c.colors.contextmenu.selected.bg = '#ebdbb2'

# Foreground color of the context menu's selected item. If set to null,
# the Qt default is used.
# Type: QssColor
c.colors.contextmenu.selected.fg = '#3c3836'

# Background color for the download bar.
# Type: QssColor
c.colors.downloads.bar.bg = '#fbf1c7'

# Color gradient start for download text.
# Type: QtColor
c.colors.downloads.start.fg = '#3c3836'

# Color gradient start for download backgrounds.
# Type: QtColor
c.colors.downloads.start.bg = '#458588'

# Color gradient end for download text.
# Type: QtColor
c.colors.downloads.stop.fg = '#3c3836'

# Color gradient stop for download backgrounds.
# Type: QtColor
c.colors.downloads.stop.bg = '#98971a'

# Foreground color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.fg = '#3c3836'

# Background color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.bg = '#cc241d'

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = '#3c3836'

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = '#fbf1c7'

# Font color for the matched part of hints.
# Type: QtColor
c.colors.hints.match.fg = '#458588'

# Text color for the keyhint widget.
# Type: QssColor
c.colors.keyhint.fg = '#3c3836'

# Highlight color for keys to complete the current keychain.
# Type: QssColor
c.colors.keyhint.suffix.fg = '#458588'

# Background color of the keyhint widget.
# Type: QssColor
c.colors.keyhint.bg = '#fbf1c7'

# Foreground color of an error message.
# Type: QssColor
c.colors.messages.error.fg = '#cc241d'

# Background color of an error message.
# Type: QssColor
c.colors.messages.error.bg = '#fbf1c7'

# Border color of an error message.
# Type: QssColor
c.colors.messages.error.border = '#928374'

# Foreground color of a warning message.
# Type: QssColor
c.colors.messages.warning.fg = '#d79921'

# Background color of a warning message.
# Type: QssColor
c.colors.messages.warning.bg = '#fbf1c7'

# Border color of a warning message.
# Type: QssColor
c.colors.messages.warning.border = '#928374'

# Foreground color of an info message.
# Type: QssColor
c.colors.messages.info.fg = '#98971a'

# Background color of an info message.
# Type: QssColor
c.colors.messages.info.bg = '#fbf1c7'

# Border color of an info message.
# Type: QssColor
c.colors.messages.info.border = '#928374'

# Foreground color for prompts.
# Type: QssColor
c.colors.prompts.fg = '#3c3836'

# Border used around UI elements in prompts.
# Type: String
c.colors.prompts.border = '1px solid #928374'

# Background color for prompts.
# Type: QssColor
c.colors.prompts.bg = '#fbf1c7'

# Background color for the selected item in filename prompts.
# Type: QssColor
c.colors.prompts.selected.bg = '#ebdbb2'

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = '#3c3836'

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = '#ebdbb2'

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = '#3c3836'

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = '#98971a'

# Foreground color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.fg = '#3c3836'

# Background color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.bg = '#458588'

# Foreground color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.fg = '#ebdbb2'

# Background color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.bg = '#3c3836'

# Foreground color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.fg = '#3c3836'

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = '#fbf1c7'

# Foreground color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.fg = '#ebdbb2'

# Background color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.bg = '#282828'

# Background color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.bg = '#3c3836'

# Foreground color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.fg = '#3c3836'

# Background color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.bg = '#689d6a'

# Background color of the progress bar.
# Type: QssColor
c.colors.statusbar.progress.bg = '#d65d0e'

# Default foreground color of the URL in the statusbar.
# Type: QssColor
c.colors.statusbar.url.fg = '#3c3836'

# Foreground color of the URL in the statusbar on error.
# Type: QssColor
c.colors.statusbar.url.error.fg = '#cc241d'

# Foreground color of the URL in the statusbar for hovered links.
# Type: QssColor
c.colors.statusbar.url.hover.fg = '#689d6a'

# Foreground color of the URL in the statusbar on successful load
# (http).
# Type: QssColor
c.colors.statusbar.url.success.http.fg = '#cc241d'

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = '#98971a'

# Foreground color of the URL in the statusbar when there's a warning.
# Type: QssColor
c.colors.statusbar.url.warn.fg = '#cc241d'

# Background color of the tab bar.
# Type: QssColor
c.colors.tabs.bar.bg = '#fbf1c7'

# Color gradient start for the tab indicator.
# Type: QtColor
c.colors.tabs.indicator.start = '#458588'

# Color gradient end for the tab indicator.
# Type: QtColor
c.colors.tabs.indicator.stop = '#98971a'

# Color for the tab indicator on errors.
# Type: QtColor
c.colors.tabs.indicator.error = '#cc241d'

# Foreground color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.fg = '#3c3836'

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = '#fbf1c7'

# Foreground color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.fg = '#3c3836'

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = '#fbf1c7'

# Foreground color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.fg = '#3c3836'

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = '#ebdbb2'

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = '#3c3836'

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = '#ebdbb2'

# Foreground color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.fg = '#b16286'

# Background color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.bg = '#fbf1c7'

# Foreground color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.fg = '#b16286'

# Background color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.bg = '#fbf1c7'

# Foreground color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.fg = '#b16286'

# Background color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.bg = '#ebdbb2'

# Foreground color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.fg = '#b16286'

# Background color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.bg = '#ebdbb2'

# Default font families to use. Whenever "default_family" is used in a
# font setting, it's replaced with the fonts listed here. If set to an
# empty value, a system-specific monospace default is used.
# Type: List of Font, or Font
c.fonts.default_family = 'JetBrains Mono'

# Default font size to use. Whenever "default_size" is used in a font
# setting, it's replaced with the size listed here. Valid values are
# either a float value with a "pt" suffix, or an integer value with a
# "px" suffix.
# Type: String
c.fonts.default_size = '12pt'

# Setup for KeePassXC connection.
config.bind('<Alt-Shift-u>', 'spawn --userscript qute-keepassxc --key 9FE01C39F74551D434116394CADE6F0C09F21B09', mode='insert')
config.bind('pw', 'spawn --userscript qute-keepassxc --key 9FE01C39F74551D434116394CADE6F0C09F21B09', mode='normal')

