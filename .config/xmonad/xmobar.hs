{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PostfixOperators    #-}

import Xmobar

main :: IO ()
main = xmobar config

config :: Config
config = defaultConfig {
    font = mainFont
    , additionalFonts = [iconFont, emojiFont]
    , bgColor  = colorBg
    , fgColor  = colorFg
    , position = TopW L 90

    , commands = myCommands
    , sepChar  = "%"
    , alignSep = "}{"
    , template = "%XMonadLog% }{ %alsa:default:Master% | %battery% | %cpu% | %memory% | %EDDB% | %date%"
}

myCommands :: [Runnable]
myCommands =
    [ Run XMonadLog
    , Run $ Weather "EDDB"
        [ "--template", "<weather> <tempC>°C"
        , "-L", "0"
        , "-H", "25"
        , "--low"   , colorBlue
        , "--normal", colorBg
        , "--high"  , colorRed
        ] (30 `minutes`)
    , Run $ Cpu
        [ "-L", "3"
        , "-H", "50"
        , "--high"  , colorRed
        , "--normal", colorGreen
        ] (10 `seconds`)
    , Run $ Alsa "default" "Master"
        [ "--template", "Vol: <volumestatus>"
        , "--suffix"  , "True"
        , "--"
        , "--on", ""
        ]
    , Run $ Memory ["--template", inEmojiFont "🧠" <> ": <usedratio>%"] (10 `seconds`)
    , Run $ Date ("%a %Y-%m-%d " <> cyan "%H:%M") "date" (10 `seconds`)
    , Run $ Battery
          [ "--template", "<acstatus>"
          , "--Low"     , "15"       -- Low  threshold for colours (in %)
          , "--High"    , "70"       -- High threshold for colours (in %)
          , "--low"     , colorRed
          , "--normal"  , colorFg
          , "--high"    , colorGreen
          , "--suffix"  , "True"     -- Display '%' after '<left>'.
          , "--"                     -- battery specific options start here.
          , "--off"     , "<left> (<timeleft>)"                         -- AC off.
          , "--on"      , yellow "Charging" <> ": <left> (<timeleft>)"  -- AC on.
          , "--idle"    , green  "Charged"  <> " <left>"                -- Fully charged.
            -- Charge strings.  These go _in front_ of the @AC off@ string,
            -- while the @AC on@ and @idle@ strings ignore them.
          , "--lowt"    , "15"       -- Low  threshold for charge strings (in %).
          , "--hight"   , "70"       -- High threshold for charge strings (in %).
          , "--lows"    , inIconFont "\62020  "
          , "--mediums" , inIconFont "\62018  "
          , "--highs"   , inIconFont "\62016  "
          ] (10 `seconds`)
    ]
      where
        -- | Convenience functions.
        seconds, minutes :: Int -> Int
        seconds = (* 10)
        minutes = (60 *) . seconds

{------------------------------COLORS-----------------------------
    All clors are from the nightfox colorscheme
-----------------------------------------------------------------}
--color8 #575860
--color9 #d16983
--color10 #8ebaa4
--color11 #e0c989
--color12 #86abdc
--color13 #baa1e2
--color14 #7ad4d6
--color15 #e4e4e5
-- # extended colors
--color16 #f4a261
--color17 #d67ad2

colorRed    :: String = "#c94f6d"
colorFg     :: String = "#f8f8f2"
colorBg     :: String = "#192330"
colorGreen  :: String = "#81b29a" 
colorYellow :: String = "#e0c989" 
colorCyan   :: String = "#63cdcf" 
colorBlue   :: String = "#86abdc"

cyan, green, yellow :: String -> String
green  = xmobarColor colorGreen   ""
yellow = xmobarColor colorYellow  ""
cyan   = xmobarColor colorCyan    ""

{- | Wrap a string in delimiters, unless it is empty.
Source: https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/src/XMonad.Hooks.DynamicLog.html#wrap
-}
wrap
  :: String  -- ^ left delimiter
  -> String  -- ^ right delimiter
  -> String  -- ^ output string
  -> String
wrap _ _ "" = ""
wrap l r m  = l <> m <> r

{- | Use xmobar escape codes to output a string with given foreground and
background colors.
Source: https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/src/XMonad.Hooks.DynamicLog.html#xmobarColor
-}
xmobarColor
  :: String  -- ^ foreground color: a color name, or #rrggbb format
  -> String  -- ^ background color
  -> String  -- ^ output string
  -> String
xmobarColor fg bg = wrap open "</fc>"
 where
  open :: String = concat ["<fc=", fg, if null bg then "" else "," <> bg, ">"]

{-----------------------------------FONTS-----------------------------------}
mainFont :: String
mainFont = "xft:DejaVu Sans:antialias=true:size=9" 

emojiFont :: String
emojiFont = "xft:Symbola-10"

iconFont :: String
iconFont = "xft:FontAwesome-9"

-- | Wrap stuff so it uses the icon font.
inIconFont :: String -> String
inIconFont = wrap "<fn=1>" "</fn>"

-- | Wrap stuff so it uses the icon font.
inEmojiFont :: String -> String
inEmojiFont = wrap "<fn=2>" "</fn>"
