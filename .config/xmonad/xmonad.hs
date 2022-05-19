{-# LANGUAGE ScopedTypeVariables #-}

import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.Loggers

import XMonad.Layout.ThreeColumns
-- import XMonad.Layout.Magnifier

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import qualified XMonad.StackSet as W

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myConfig = def
  { modMask = mod4Mask
  , terminal = myTerminal

  , focusedBorderColor = myFocusedBorderColor
  , normalBorderColor = myUnfocusedBorderColor
  , borderWidth = myBorderWidth

  , layoutHook = myLayout
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
    , volumeKeys
    , windowsKeys
    ]

appKeys :: Keybindings
appKeys = 
    [ ("M-o", spawn myBrowser)
    , ("M-<Return>", spawn myTerminal) 
    , ("M-S-<Print>", unGrab *> spawn "scrot -s")
    , ("M-d", spawnLauncher)
    , ("<XF86AudioPrev>", play "prev")
    , ("<XF86AudioNext>", play "next")
    , ("<XF86AudioPlay>", play "toggle")
    , ("<XF86AudioPause>", play "toggle")
    ]
  where
    spawnLauncher :: X ()
    spawnLauncher = spawn $ myLauncher <> " -combi-mode window,drun,ssh -show combi"

    play :: String -> X ()
    play = spawn . (playerCommand <>)
    playerCommand :: String
    playerCommand = "playerctl -p $(playerctl -l | grep " <> myPlayer <> ") "

volumeKeys :: Keybindings
volumeKeys = 
    [ ("<XF86AudioRaiseVolume>", volume "+5000"   )
    , ("<XF86AudioLowerVolume>", volume "-5000"   )
    , ("<XF86AudioMute>"       , volume "toggle"  )
    ]
  where
    volume :: String -> X ()
    volume = spawn . ("pactl set-sink-volume @DEFAULT_SINK@" <>)

windowsKeys :: Keybindings
windowsKeys =
    [ ("M-c", kill) -- kill current window 
    , ("M-t", windows W.focusDown) -- next window
    , ("M-n", windows W.focusUp) -- prev window
    , ("M-S-t", windows W.swapDown) -- swap with the next
    , ("M-S-n", windows W.swapUp) -- swap with the prev
    ]

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


colorBg       :: String = "#192330"
colorFg       :: String = "#f8f8f2"
colorYellow   :: String = "#e0c989"
colorCyan     :: String = "#63cdcf"
colorBlue     :: String = "#86abdc"
colorLowWhite :: String = "#bbbbbb"
colorMagenta  :: String = "#baa1e2"
colorOrange   :: String = "#f4a261"
colorRed      :: String = "#c94f6d"

yellow, blue, lowWhite, white, magenta, orange, red :: String -> String
yellow   = xmobarColor colorYellow ""
white    = xmobarColor colorFg ""
lowWhite = xmobarColor colorLowWhite ""
blue     = xmobarColor colorBlue ""
magenta  = xmobarColor colorMagenta ""
orange   = xmobarColor colorOrange ""
red      = xmobarColor colorRed ""

myTerminal :: String
myTerminal = "/usr/bin/kitty"

myLauncher :: String
myLauncher = "/usr/bin/rofi"

myBrowser :: String
myBrowser = "/usr/bin/brave"

myPlayer :: String
myPlayer = "/usr/bin/spotify"

myFocusedBorderColor :: String
myFocusedBorderColor = colorBlue

myUnfocusedBorderColor :: String
myUnfocusedBorderColor = colorBg

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
-- myManageHook = composeAll
--     [ className =? "Chromium"       --> doShift "2:web"
--     , className =? "Google-chrome"  --> doShift "2:web"
--     , resource  =? "desktop_window" --> doIgnore
--     , className =? "Galculator"     --> doFloat
--     , className =? "Steam"          --> doFloat
--     , className =? "Gimp"           --> doFloat
--     , resource  =? "gpicview"       --> doFloat
--     , className =? "MPlayer"        --> doFloat
--     , className =? "VirtualBox"     --> doShift "4:vm"
--     , className =? "Xchat"          --> doShift "5:media"
--     , className =? "stalonetray"    --> doIgnore
--     , isFullscreen --> (doF W.focusDown <+> doFullFloat)]

