{-# LANGUAGE PostfixOperators #-}
{-# LANGUAGE ScopedTypeVariables #-}

import Xmobar

main :: IO ()
main = xmobar config

data HaskellIcon = HaskellIcon deriving (Show, Read)

instance Exec HaskellIcon where
  alias HaskellIcon = "hasIcon"
  run HaskellIcon = return $ purple $ ("  " ++) $ inIconFont "\58911" -- ""

config :: Config
config =
  defaultConfig
    { font = mainFont
    , additionalFonts = [iconFont, emojiFont]
    , bgColor = colorBg
    , fgColor = colorFg
    , position = TopHM 22 0 96 0 0 -- height 22, right margin 96px for stalonetray
    , commands = myCommands
    , sepChar = "%"
    , alignSep = "}{"
    , template =
        "%hasIcon% | %XMonadLog% }{ %bright% | %vol% | %battery% | "
          <> onClick (popup "100c" "30c" "htop -s PERCENT_CPU") "%cpu%" -- live, sorted by CPU
          <> " | "
          <> onClick (popup "40c" "16c" "zsh -c 'mem 15; read -sk1'") "%memory%" -- any key closes
          <> " | %EDDB% | %date%"
    }

myCommands :: [Runnable]
myCommands =
  [ Run XMonadLog
  , Run $
      Weather
        "EDDB"
        [ "--template"
        , "<weather> <tempC>°C"
        , "-L"
        , "0"
        , "-H"
        , "25"
        , "--low"
        , colorBlue
        , "--normal"
        , colorFg
        , "--high"
        , colorRed
        ]
        (30 `minutes`)
  , Run $
      Cpu
        [ "-L"
        , "3"
        , "-H"
        , "50"
        , "--high"
        , colorRed
        , "--normal"
        , colorGreen
        , "--template"
        , inIconFont "\62171" <> "<total>%"
        ]
        (10 `seconds`)
  , Run $
      Com
        "bash"
        [ "-c"
        , "v=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+(?=%)' | head -1); "
            <> "if pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes; "
            <> ("then echo '" <> inIconFont "\984927" <> red "Muted" <> "'; ")
            <> ("else echo '" <> inIconFont "\61480" <> "'\"$v\"'%'; fi")
        ]
        "vol"
        (2 `seconds`)
  , Run $
      Brightness
        ["--template", inIconFont "\983263" <> "<percent>%", "--", "-D", "intel_backlight"]
        (2 `seconds`)
  , Run $ Memory ["--template", inAltIconFont "🧠" <> " <usedratio>%"] (10 `seconds`)
  , Run $ Date ("%a %Y-%m-%d " <> cyan "%H:%M") "date" (10 `seconds`)
  , Run $
      Battery
        [ "--template"
        , "<acstatus>"
        , "--Low"
        , "15" -- Low  threshold for colours (in %)
        , "--High"
        , "70" -- High threshold for colours (in %)
        , "--low"
        , colorRed
        , "--normal"
        , colorFg
        , "--high"
        , colorGreen
        , "--suffix"
        , "True" -- Display '%' after '<left>'.
        , "--" -- battery specific options start here.
        , "--off"
        , "<left> (<timeleft>)" -- AC off.
        , "--on"
        , inIconFont "\61671" <> yellow "Charging" <> " <left> (<timeleft>)" -- AC on.
        , "--idle"
        , inIconFont "\61926" <> green "Charged" <> " <left>" -- Fully charged.
        -- Charge strings.  These go _in front_ of the @AC off@ string,
        -- while the @AC on@ and @idle@ strings ignore them.
        , "--lowt"
        , "15" -- Low  threshold for charge strings (in %).
        , "--hight"
        , "70" -- High threshold for charge strings (in %).
        , "--lows"
        , inIconFont "\62020"
        , "--mediums"
        , inIconFont "\62018"
        , "--highs"
        , inIconFont "\62016"
        ]
        (10 `seconds`)
  , Run HaskellIcon
  ]
  where
    -- \| Convenience functions.
    seconds, minutes :: Int -> Int
    seconds = (* 10)
    minutes = (60 *) . seconds

{------------------------------COLORS-----------------------------
    All clors are from the nightfox colorscheme
-----------------------------------------------------------------}
-- color8 #575860
-- color9 #d16983
-- color10 #8ebaa4
-- color11 #e0c989
-- color12 #86abdc
-- color13 #baa1e2
-- color14 #7ad4d6
-- color15 #e4e4e5
-- # extended colors
-- color16 #f4a261
-- color17 #d67ad2

colorRed :: String = "#c94f6d"
colorFg :: String = "#f8f8f2"
colorBg :: String = "#192330"
colorGreen :: String = "#81b29a"
colorYellow :: String = "#e0c989"
colorCyan :: String = "#63cdcf"
colorBlue :: String = "#86abdc"
colorPurple :: String = "#7b6f9c"

purple, cyan, green, yellow, red :: String -> String
red = xmobarColor colorRed ""
purple = xmobarColor colorPurple ""
green = xmobarColor colorGreen ""
yellow = xmobarColor colorYellow ""
cyan = xmobarColor colorCyan ""

{- | Wrap a string in delimiters, unless it is empty.
Source: https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/src/XMonad.Hooks.DynamicLog.html#wrap
-}
wrap ::
  -- | left delimiter
  String ->
  -- | right delimiter
  String ->
  -- | output string
  String ->
  String
wrap _ _ "" = ""
wrap l r m = l <> m <> r

{- | Use xmobar escape codes to output a string with given foreground and
background colors.
Source: https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/src/XMonad.Hooks.DynamicLog.html#xmobarColor
-}
xmobarColor ::
  -- | foreground color: a color name, or #rrggbb format
  String ->
  -- | background color
  String ->
  -- | output string
  String ->
  String
xmobarColor fg bg = wrap open "</fc>"
  where
    open :: String = concat ["<fc=", fg, if null bg then "" else "," <> bg, ">"]

-- | Left click on a template part runs a command.
onClick :: String -> String -> String
onClick cmd s = "<action=`" <> cmd <> "` button=1>" <> s <> "</action>"

-- | Command in a small kitty window (width, height in cells); xmonad floats it centered.
popup :: String -> String -> String -> String
popup w h cmd =
  unwords
    [ "kitty --class xmobar-popup -o remember_window_size=no"
    , "-o initial_window_width=" <> w
    , "-o initial_window_height=" <> h
    , cmd
    ]

{-----------------------------------FONTS-----------------------------------}
mainFont :: String
mainFont = "DejaVu Sans 11"

emojiFont :: String
emojiFont = "Symbola 10"

iconFont :: String
iconFont = "Symbols Nerd Font 10"

-- | Wrap stuff so it uses the icon font.
inIconFont :: String -> String
inIconFont = wrap "<fn=1>" "</fn>  "

-- | Wrap stuff so it uses the icon font.
inAltIconFont :: String -> String
inAltIconFont = wrap "<fn=2>" "</fn>"
