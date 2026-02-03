{-# LANGUAGE ScopedTypeVariables #-}

import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.Loggers

import XMonad.Layout.ThreeColumns
-- import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders (smartBorders)

import XMonad.Actions.CycleWS (Direction1D (Prev, Next), WSType (Not), moveTo, emptyWS)
import XMonad.Actions.CycleRecentWS (toggleRecentWS)

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WorkspaceHistory (workspaceHistoryHook)

import qualified XMonad.StackSet as W

myLayout = smartBorders
  . mkToggle (single NBFULL)
  $ tiled
  ||| Mirror tiled
  ||| Full
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
  , manageHook         = myManageHook
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
    , ("<Print>"     , unGrab *> printscreen "")
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

mediaKeys :: Keybindings
mediaKeys =
    [ ("<XF86AudioRaiseVolume>", volume "5%+"   )
    , ("<XF86AudioLowerVolume>", volume "5%-"   )
    , ("<XF86AudioMute>"       , volume "toggle")
    , ("<XF86AudioPrev>"       , play "previous")
    , ("<XF86AudioNext>"       , play "next")
    , ("<XF86AudioPlay>"       , play "play-pause")
    , ("<XF86AudioPause>"      , play "play-pause")
    ]
  where
    volume :: String -> X ()
    volume = spawn . ("amixer -q set Master " <>)

    play :: String -> X ()
    play = spawn . (playerCommand <>)
    playerCommand :: String
    playerCommand = "playerctl -p $(playerctl -l | grep " <> myPlayer <> ") "

windowsKeys :: Keybindings
windowsKeys =
    [ ("M-S-c"     , kill) -- kill current window
    , ("M-f"       , toggleFullScreen)
    , ("M-t"       , windows W.focusDown) -- next window
    , ("M-n"       , windows W.focusUp) -- prev window
    , ("M-S-t"     , windows W.swapDown) -- swap with the next
    , ("M-S-n"     , windows W.swapUp) -- swap with the prev

    , ("M-<Left>"  , moveTo  Prev $ Not emptyWS) -- prev workspace
    , ("M-<Right>" , moveTo Next $ Not emptyWS) -- next workspace
    , ("M-S-<Tab>" , toggleRecentWS) -- go to most recent workspace
    ]
      where
        toggleFullScreen :: X ()
        toggleFullScreen = sendMessage $ Toggle NBFULL

main :: IO ()
main = xmonad
     . ewmhFullscreen
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

-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below
--
myManageHook = composeAll 
    [ className =? "Galculator"     --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Lxappearance"   --> doFloat
    , className =? "Pavucontrol"          --> doFloat
    ]
    -- , className =? "stalonetray"    --> doIgnore
    -- , isFullscreen --> (doF W.focusDown <+> doFullFloat)]
