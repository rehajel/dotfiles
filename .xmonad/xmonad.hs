import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Layout.NoBorders
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Actions.FloatKeys
import XMonad.Util.SpawnOnce
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Grid
import XMonad.Layout.Spacing
--import XMonad.Layout.ThreeColumns
--import XMonad.Layout.MultiColumns
import XMonad.Layout.ZoomRow
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import qualified Data.Map as M

---- MISC
myNormalBorderColor = "#5a5a5a"
myFocusedBorderColor = "#0fc4b2"
myBorderWidth = 0
mySpacingWidth = 4
myfadeAmount = 0.9
mySpacing = spacingRaw True (Border 4 4 4 4) True (Border 0 0 mySpacingWidth 0) True
myModMask = mod4Mask
myTerminal = "alacritty"
cmus = myTerminal ++ " --title cmus -e cmus"
neomutt = myTerminal ++ " --title neomutt -e neomutt"
newsboat = myTerminal ++ " --title newsboat -e newsboat"
pulsemixer = myTerminal ++ " --title pulsemixer -e pulsemixer"
calculator = myTerminal ++ " --title calc -e calc"
ranger = myTerminal ++ " --title ranger -e ranger"
screenshot = "flameshot gui"
myLauncher = "/usr/bin/rofi -show run"
myWorkspaces = ["1","2","3","4","5","6","7","8","9","0"]
myFocusFollowsMouse = False
myClickJustFocuses = False

---- APP RULES
myManageHook = composeAll [
    --className =? "qutebrowser"      --> doShift "2",
    --title     =? "cmus"             --> doShift "0",
    --className =? "discord"          --> doShift "9",
    --className =? "Bitwarden"        --> doShift "8",
    className =? "Yad"              --> doCenterFloat,
    title     =? "pulsemixer"       --> doCenterFloat,
    title     =? "calc"             --> doCenterFloat,
    title     =? "neomutt"          --> (doRectFloat $ W.RationalRect 0.32 0.2 0.4 0.7),
    title     =? "ranger"           --> (doRectFloat $ W.RationalRect 0.32 0.2 0.4 0.7),
    className =? "Thunar"           --> doCenterFloat
    --insertPosition Below Newer
    ]

---- STARTUP
myStartupHook = do
    setWMName "LG3D"
    -- Focus the second screen.
    --screenWorkspace 1 >>= flip whenJust (windows . W.view)
    -- Force the second screen to "9", e.g. if the first screen already has
    -- the workspace associated the screens will swap workspaces.
    --windows $ W.greedyView "9"
    -- Focus the first screen again.
    --screenWorkspace 0 >>= flip whenJust (windows . W.view)
    -- Launch Startup Stuff
    --spawnOnOnce "9" "discord"
    --spawnOnOnce "8" "bitwarden"
    --spawnOnOnce "9" "telegram-desktop"
    --spawnOnOnce "9" cmus
    spawn "feh --bg-center ~/Wallpapers/Ultrawide/wallpapers_hatschl/Oriental_2.jpg"
    spawnOnce "picom -bc --config ~/.config/picom.conf"
    spawnOnce "unclutter &"
    spawnOnce "dunst &"
    spawnOnce "~/.scripts/battery_notify"
    spawnOnce "~/.scripts/mailwatch"
    spawnOnce "clipster -d"
    --spawnOnOnce "4" "mailspring"

---- KEY CONFIG
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
-- Custom Key Bindings
    [ 
      -- Restart XMonad
      ((modMask .|. shiftMask,      xK_r),              restart "xmonad" True),
      -- Move Focus
      ((modMask,                    xK_space),          windows W.focusMaster),
      ((modMask,                    xK_j),              windows W.focusDown),
      ((modMask,                    xK_k),              windows W.focusUp),
      -- Swap Monitors
      --((modMask,                    xK_w),              swapNextScreen),
      -- Focus Monitors
      --((modMask,                    xK_q),              nextScreen),
      -- Move Window to next Screen
      --((modMask .|. shiftMask,      xK_q),              shiftNextScreen >> nextScreen),
      -- Move Windows in Layout
      ((modMask .|. shiftMask,      xK_j),              windows W.swapDown),
      ((modMask .|. shiftMask,      xK_k),              windows W.swapUp),
      ((modMask .|. shiftMask,      xK_space),          windows W.swapMaster),
      -- Change Size
      --((modMask,                    xK_l),              sendMessage Expand),
      --((modMask,                    xK_h),              sendMessage Shrink),
      -- Change Size in zoomRow Layout
      ((modMask,                    xK_l),              sendMessage (Zoom 1.15)),
      ((modMask,                    xK_h),              sendMessage (Zoom 0.90)),
      -- Floating Stuff
      ((modMask,                    xK_o),              withFocused $ windows . W.sink),
      ((modMask .|. shiftMask,      xK_o),              withFocused (keysMoveWindowTo(1200,0)(0,0)) <+> withFocused (keysResizeWindow (-2400,0)(0,0))),
      ((modMask,                    xK_comma),          withFocused (keysResizeWindow (-200,0)(0,0))),
      ((modMask,                    xK_period),         withFocused (keysResizeWindow (200,0)(0,0))),
      ((modMask .|. shiftMask,      xK_h),              withFocused (keysMoveWindow (-100,0))),
      ((modMask .|. shiftMask,      xK_l),              withFocused (keysMoveWindow (100,0))),
      -- Change Layouts
      ((modMask,                    xK_Tab),            sendMessage NextLayout),
      -- Reset Layouts
      ((modMask .|. shiftMask,      xK_Tab),            setLayout $ XMonad.layoutHook conf),
      -- Kill App
      ((modMask .|. shiftMask,      xK_x),              kill),
      --Spawn Apps
      ((modMask,                    xK_d),              spawnHere "/usr/bin/rofi -show run"),
      ((modMask,                    xK_i),              spawnHere "firefox"),
      ((modMask .|. shiftMask,      xK_i),              spawnHere "firefox --private-window duckduckgo.com"),
      ((modMask,                    xK_m),              spawn cmus), 
      ((modMask,                    xK_u),              spawn calculator), 
      ((modMask .|. shiftMask,      xK_m),              spawnHere pulsemixer),
      ((modMask,                    xK_g),              spawnHere neomutt),
      ((modMask,                    xK_e),              spawnHere ranger),
      ((modMask,                    xK_Return),         spawnHere myTerminal),
      ((modMask,                    xK_x),              spawnHere screenshot),
      ((modMask,                    xK_c),              spawnHere "~/.scripts/clock"),
      ((modMask .|. shiftMask,      xK_c),              spawnHere "~/.scripts/popupcalendar --popup"),
      ((modMask,                    xK_v),              spawnHere "roficlip"),
      ((modMask,                    xK_s),              spawnHere "~/.scripts/cmus_notify"),
      ((modMask,                    xK_t),              spawn "~/.scripts/trackball_scroll_toggle"),
      ((modMask,                    xK_b),              spawnHere "~/.scripts/battery_status"),
      ((modMask .|. shiftMask,      xK_p),              spawnHere "~/.scripts/pauseallmpv"),
      ((modMask,                    xK_p),              spawnHere "cmus-remote -u"),
      ((modMask .|. shiftMask,      xK_n),              spawnHere newsboat),
      ((modMask,                    xK_n),              spawnHere "cmus-remote -n")
    ] ++
    [ ((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0]),
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ] 


--- LAYOUTS
myLayout = mySpacing $ smartBorders $ onWorkspace "5" Grid zoom ||| noBorders (Full)
    where
        --tiled = ThreeColMid nmaster delta ratio
        nmaster = 1
        delta = 3/100
        ratio = 1/3
        --multicol = multiCol nrowmaster nrowslaves resizeratio mastersize
        nrowmaster = [1]
        nrowslaves = 1
        resizeratio = 0.01
        mastersize  = (0.4)
        zoom = zoomRow

--- logHook (Transparancy for inactive windows)
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
        where fadeAmount = myfadeAmount 
---- MAIN
main = do
    xmonad $ ewmh defaults {
        startupHook = myStartupHook,
        logHook = myLogHook
    }

defaults = def {
    terminal = myTerminal,
    borderWidth = myBorderWidth,
    modMask = myModMask,
    workspaces = myWorkspaces,
    normalBorderColor = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
    keys = myKeys,
    layoutHook = myLayout,
    manageHook = manageSpawn <+> myManageHook,
    focusFollowsMouse = myFocusFollowsMouse,
    clickJustFocuses = myClickJustFocuses
}
