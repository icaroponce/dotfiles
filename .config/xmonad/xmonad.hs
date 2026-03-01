{-# LANGUAGE ScopedTypeVariables #-}

import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

import XMonad.Layout.ThreeColumns
-- import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Fullscreen

import XMonad.Actions.CycleWS (Direction1D (Prev, Next), WSType (Not), moveTo, emptyWS)
import XMonad.Actions.CycleRecentWS (toggleRecentWS)

import XMonad.Hooks.EwmhDesktops hiding (fullscreenEventHook)
import XMonad.Hooks.ManageHelpers (doCenterFloat)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WorkspaceHistory (workspaceHistoryHook)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myLayout = fullscreenFull $ smartBorders
  . mkToggle (single NBFULL)
  $ tiled
  ||| Mirror tiled
  ||| threeCol
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myConfig = def
  { modMask            = mod4Mask
  , terminal           = myTerminal

  , focusedBorderColor = myFocusedBorderColor
  , normalBorderColor  = myUnfocusedBorderColor
  , borderWidth        = myBorderWidth

  , layoutHook         = myLayout
  , manageHook         = myManageHook <> fullscreenManageHook
  , handleEventHook    = fullscreenEventHook
  , logHook            = workspaceHistoryHook
  }
  `additionalKeysP`
  myKeys

-- | A keybinding is a key (encoded via the 'EZConfig', Emacs-like
-- encoding), together with an action that executes once that key is
-- pressed.
type Keybinding = (String, X ())

-- | Lots of keybindings.
type Keybindings = [Keybinding]

myKeys :: Keybindings
myKeys = concat
    [ appKeys
    , mediaKeys
    , windowsKeys
    ]

appKeys :: Keybindings
appKeys =
    [ ("M-o"         , spawn myBrowser)
    , ("M-<Return>"  , spawn myTerminal)
    , ("M-d"         , spawnLauncher)
    , ("M-S-q"       , lockscreen)
    -- printscreen bindings
    , ("<Print>"     , unGrab *> printscreenFlameshot)
    , ("M-S-<Print>" , unGrab *> printscreen "-s")
    , ("M-<Print>"   , unGrab *> printscreen "-u")
    -- dunst bindings
    , ("M1-<Space>"  , spawn "dunstctl close")
    , ("M1-S-<Space>", spawn "dunstctl close-all")
    , ("M1-<Escape>" , spawn "dunstctl history-pop")
    ]
  where
    spawnLauncher :: X ()
    spawnLauncher = spawn $ myLauncher <> " -combi-mode window,drun,ssh -theme gruvbox-dark -show combi"

    lockscreen :: X ()
    lockscreen = spawn "i3lock-fancy-rapid 5 3"

    printscreen :: String -> X ()
    printscreen flag = spawn $ "scrot " <> flag  <> " ~/Screenshots/$(date '+%Y-%m-%dT%H:%M:%S.png')"

    printscreenFlameshot :: X ()
    printscreenFlameshot = spawn "flameshot gui"

mediaKeys :: Keybindings
mediaKeys =
    [ ("<XF86AudioRaiseVolume>", volume "+5%"   )
    , ("<XF86AudioLowerVolume>", volume "-5%"   )
    , ("<XF86AudioMute>"       , volume "toggle")
    , ("<XF86AudioPrev>"       , play "previous")
    , ("<XF86AudioNext>"       , play "next")
    , ("<XF86AudioPlay>"       , play "play-pause")
    , ("<XF86AudioPause>"      , play "play-pause")
    ]
  where
    volume :: String -> X ()
    volume "toggle" = spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    volume vol      = spawn $ "pactl set-sink-volume @DEFAULT_SINK@ " <> vol

    play :: String -> X ()
    play = spawn . (playerCommand <>)
    playerCommand :: String
    playerCommand = "playerctl -p $(playerctl -l | grep " <> myPlayer <> ") "

windowsKeys :: Keybindings
windowsKeys =
    [ ("M-S-c"     , kill) -- kill current window
    , ("M-f"       , toggleFullScreen)
    , ("M-S-f"     , withFocused toggleFloat) -- float/sink toggle
    , ("M-t"       , windows W.focusDown) -- next window
    , ("M-n"       , windows W.focusUp) -- prev window
    , ("M-S-t"     , windows W.swapDown) -- swap with the next
    , ("M-S-n"     , windows W.swapUp) -- swap with the prev

    , ("M-<Left>"  , moveTo  Prev $ Not emptyWS) -- prev workspace
    , ("M-<Right>" , moveTo Next $ Not emptyWS) -- next workspace
    , ("M-<Tab>"   , toggleRecentWS) -- go to most recent workspace
    ]
      where
        toggleFullScreen :: X ()
        toggleFullScreen = sendMessage $ Toggle NBFULL

main :: IO ()
main = xmonad
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myXmobarPP :: PP
myXmobarPP = def
    { ppSep   = magenta " | "
    , ppTitleSanitize = xmobarStrip
    , ppCurrent = wrap " " "" . xmobarBorder "Top" colorCyan 2
    , ppHidden = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent = red . wrap (yellow "!") (yellow "!")
    , ppOrder = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (white "[[") (white "]]") . orange . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow

    -- shortens windows title, which is required 
    ppWindow :: String -> String
    ppWindow  = xmobarRaw . (\w -> if null w then "Untitled" else w) . shorten 30


colorRed, colorBg, colorFg, colorYellow, colorCyan, colorBlue, colorLowWhite, colorMagenta, colorOrange :: String
colorBg       = "#192330"
colorFg       = "#f8f8f2"
colorYellow   = "#e0c989"
colorCyan     = "#63cdcf"
colorBlue     = "#86abdc"
colorLowWhite = "#bbbbbb"
colorMagenta  = "#baa1e2"
colorOrange   = "#f4a261"
colorRed      = "#c94f6d"

yellow, blue, lowWhite, white, magenta, orange, red :: String -> String
yellow   = xmobarColor colorYellow ""
white    = xmobarColor colorFg ""
lowWhite = xmobarColor colorLowWhite ""
blue     = xmobarColor colorBlue ""
magenta  = xmobarColor colorMagenta ""
orange   = xmobarColor colorOrange ""
red      = xmobarColor colorRed ""

myTerminal :: String
myTerminal = "kitty"

myLauncher :: String
myLauncher = "rofi"

myBrowser :: String
myBrowser = "brave"

myPlayer :: String
myPlayer = "spotify"

myFocusedBorderColor :: String
myFocusedBorderColor = colorBlue

myUnfocusedBorderColor :: String
myUnfocusedBorderColor = colorBg

myBorderWidth :: Dimension
myBorderWidth = 2

toggleFloat :: Window -> X ()
toggleFloat w = windows $ \s ->
    if M.member w (W.floating s)
        then W.sink w s
        else W.float w (W.RationalRect 0.1 0.1 0.8 0.8) s

-- Window rules: float specific applications centered on screen.
-- To find the className of any window: run `xprop | grep WM_CLASS` and click
-- the window. Use the SECOND quoted value (res_class) for className matches.
myManageHook = composeAll
    [ className =? "Galculator"   --> doCenterFloat
    , className =? "gimp"         --> doCenterFloat  -- GIMP 3.0 (GTK4) uses lowercase
    , className =? "Lxappearance" --> doCenterFloat
    , className =? "pavucontrol"  --> doCenterFloat
    , className =? "Blueman-manager" --> doCenterFloat
 -- , className =? "stalonetray"    --> doIgnore
 -- , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]
