import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Grid
import qualified XMonad.StackSet as W
import qualified Data.Map as M

---- MISC
myNormalBorderColor = "#5a5a5a"
myFocusedBorderColor = "#B0BEC5"
myBorderWidth = 1
myModMask = mod4Mask
cmus = myTerminal ++ " --title cmus -e cmus"
newsboat = myTerminal ++ " --title newsboat -e newsboat"
myTerminal = "alacritty"
myLauncher = "/usr/bin/rofi -show run"
myWorkspaces = ["1","2","3","4","5","6","7","8","9","0"]

---- APP RULES
myManageHook = composeAll [
    --className =? "qutebrowser"      --> doShift "2",
    title     =? "cmus"             --> doShift "0",
    className =? "discord"          --> doShift "9",
    --className =? "Bitwarden"        --> doShift "8",
    className =? "Yad"              --> doFloat,
    className =? "Thunar"           --> doFloat]

---- STARTUP
myStartupHook = do
    setWMName "LG3D"
    -- Focus the second screen.
    screenWorkspace 1 >>= flip whenJust (windows . W.view)
    -- Force the second screen to "9", e.g. if the first screen already has
    -- the workspace associated the screens will swap workspaces.
    windows $ W.greedyView "9"
    -- Focus the first screen again.
    screenWorkspace 0 >>= flip whenJust (windows . W.view)
    -- Launch Startup Stuff
    spawnOn "9" "discord"
    spawnOn "8" "bitwarden-bin"
    spawnOn "9" "telegram-desktop"
    spawn "feh --bg-scale ~/Wallpapers/Climbing/MoonLoveComic.png"
    spawn "compton -bc --config ~/.config/compton.conf"
    spawn "unclutter &"
    spawn "dunst &"
    spawn "~/.scripts/battery_notify"
myFocusFollowsMouse = False

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
      ((modMask,                    xK_w),              swapNextScreen),
      -- Focus Monitors
      ((modMask,                    xK_q),              nextScreen),
      -- Move Window to next Screen
      ((modMask .|. shiftMask,      xK_q),              shiftNextScreen >> nextScreen),
      -- Move Windows in Layout
      ((modMask .|. shiftMask,      xK_j),              windows W.swapDown),
      ((modMask .|. shiftMask,      xK_k),              windows W.swapUp),
      ((modMask .|. shiftMask,      xK_Return),         windows W.swapMaster),
      -- Change Size
      ((modMask,                    xK_l),              sendMessage Expand),
      ((modMask,                    xK_h),              sendMessage Shrink),
      -- Change Layouts
      ((modMask,                    xK_Tab),            sendMessage NextLayout),
      -- Reset Layouts
      ((modMask .|. shiftMask,      xK_Tab),            setLayout $ XMonad.layoutHook conf),
      -- Kill App
      ((modMask .|. shiftMask,      xK_x),              kill),
      --Spawn Apps
      ((modMask,                    xK_d),              spawn "/usr/bin/rofi -show run"),
      ((modMask,                    xK_i),              spawn "qutebrowser"),
      ((modMask,                    xK_m),              spawn cmus), 
      ((modMask,                    xK_Return),         spawn $ XMonad.terminal conf),
      ((modMask,                    xK_e),              spawnOn "7" "thunar"),
      ((modMask .|. shiftMask,      xK_n),              spawn newsboat),
      ((modMask,                    xK_c),              spawn "~/.scripts/clock"),
      ((modMask .|. shiftMask,      xK_c),              spawn "~/.scripts/popupcalendar --popup"),
      ((modMask,                    xK_s),              spawn "~/.scripts/cmus_notify"),
      ((modMask,                    xK_b),              spawn "~/.scripts/battery_status"),
      ((modMask .|. shiftMask,      xK_p),              spawn "~/.scripts/pauseallmpv"),
      ((modMask,                    xK_p),              spawn "cmus-remote -u"),
      ((modMask,                    xK_n),              spawn "cmus-remote -n")
    ] ++
    [ ((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0]),
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ] 


--- LAYOUTS
--myLayout = lessBorders (OtherIndicated) (tiled) ||| noBorders (Full)
myLayout =  onWorkspace "5" (lessBorders (Screen)Grid) (lessBorders (Screen) tiled) ||| noBorders (Full)
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 1/1.8
        delta = 3/100

---- MAIN
main = do
    xmonad $ defaults {
        startupHook = myStartupHook
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
    focusFollowsMouse = myFocusFollowsMouse
}
