# import stuff
import time
import os, subprocess
from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.command import lazy
from libqtile import layout, hook#, widget, bar

try:
    from typing import List  # noqa: F401
except ImportError:
    pass

# set 'mod' to super key
mod = "mod4"

# set terminal variable
term = "alacritty"

# Key bindings
keys = [
    ## Window positioning etc
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

    # Move windows up or down in current stack
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),

    # change size of current window -differnet layouts use different methods
    Key([mod], "equal", lazy.layout.grow()),
    # Key([mod], "equal", lazy.layout.increase_ratio()),
    Key([mod], "minus", lazy.layout.shrink()),
    # Key([mod], "minus", lazy.layout.decrease_ratio()),

    # toggle window fullscreen
    Key([mod], "f", lazy.window.toggle_fullscreen()),

    # toggle window floating
    Key([mod], "space", lazy.window.toggle_floating()),

    # Toggle between different layouts
    Key([mod], "Tab", lazy.next_layout()),

    # Kill Current Window
    Key([mod], "w", lazy.window.kill()),

    # Restart/Shutdown Qtile
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "q", lazy.shutdown()),

    ## Apps etc.
    # Start Apps with keys
    Key([mod], "Return", lazy.spawn(term)),
    Key([mod], "i", lazy.spawn("qutebrowser")),
    Key([mod], "d", lazy.spawn("rofi -show run")),
    Key([mod], "m", lazy.spawn(term+" --title cmus -e cmus")),
    Key([mod], "e", lazy.spawn("thunar")),
    Key([mod, "shift"], "n", lazy.spawn(term+" --title newsboat -e newsboat")),

    # Start Scripts with keys
    Key([mod], "c", lazy.spawn("/home/rehajel/.scripts/clock")),
    Key([mod], "s", lazy.spawn("/home/rehajel/.scripts/cmus_notify")),
    Key([mod, "shift"], "c", lazy.spawn("/home/rehajel/.config/polybar/popupcalendar.sh --popup")),
    Key([mod], "b", lazy.spawn("/home/rehajel/.scripts/battery_status")),
    Key([mod, "shift"], "p", lazy.spawn("/home/rehajel/.scripts/pauseallmpv")),
    Key([mod], "F1", lazy.spawn("cmus-remote -u")),
    Key([mod], "F2", lazy.spawn("cmus-remote -r")),
    Key([mod], "F3", lazy.spawn("cmus-remote -n")),
    Key([mod], "p", lazy.spawn("cmus-remote -u")),
    Key([mod], "n", lazy.spawn("cmus-remote -n")),
]

# Autostart Config
@hook.subscribe.startup
def autostart():
    always = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([always])

@hook.subscribe.startup_once
def autostart():
    once = os.path.expanduser('~/.config/qtile/autostart_once.sh')
    subprocess.call([once])
    processes = [
            ['discord'],
            #['telegram-desktop'],
            ['bitwarden-bin'],
    ]
    for p in processes:
        subprocess.Popen(p)

# Group Config
#groups = [Group(i) for i in "1234567890"]
groups = [
        Group('1',screen_affinity=1),
        #Group('2', spawn='qutebrowser', matches=[Match(wm_class=['qutebrowser'])]),
        Group('2',screen_affinity=1),
        Group('3',screen_affinity=1),
        Group('4',screen_affinity=1),
        Group('5', layouts=[layout.Matrix(border_focus='#dddddd'),layout.Max()],screen_affinity=1),
        Group('6',screen_affinity=1),
        Group('7',screen_affinity=1),
        Group('8', matches=[Match(wm_class=['Bitwarden'])],screen_affinity=1),
        Group('9', matches=[Match(wm_class=['discord', 'TelegramDesktop'])],screen_affinity=2),
        Group('0', matches=[Match(title=['cmus'])],screen_affinity=1),
]
for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

# Layouts Config
layouts = [
    # layout.Tile(ratio=0.58,add_on_top=True,add_after_last=True),
    layout.MonadTall(border_focus='#dddddd',single_border_width=0,border_width=1,ratio=0.56),
    layout.Max(),
    # layout.Matrix(border_focus='#dddddd'),
]

# Widgets...?
#widget_defaults = dict(
 #   font='sans',
  #  fontsize=12,
   # padding=3,
#)
#extension_defaults = widget_defaults.copy()

# Screens Config
screens = [
    Screen(
        #bottom=bar.Bar(
         #   [
          #      widget.GroupBox(),
           #     widget.WindowName(),
            #    widget.Systray(),
            #],
            #24,
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

# ??????
dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False

# Floating Rules
floating_layout = layout.Floating(float_rules=[
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
    {'wmclass': 'Thunar'},
    {'wmclass': 'Yad'},
])
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "LG3D"
