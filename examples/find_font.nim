#[
Ported from:
https://gist.github.com/CallumDev/7c66b3f9cf7a876ef75f
]#

import fontconfig
proc findFont(s: string): string =
  echo FcInit()
  let cfg = FcInitLoadConfigAndFonts()
  # make pattern from font name
  let name = cast[ptr TFcChar8](cstring(s))
  let pat = FcNameParse(name)
  echo FcConfigSubstitute(cfg, pat, FcMatchPattern)
  FcDefaultSubstitute(pat)
  var fontFile: cstring # this is what we'd return if this was a function
  # find the font
  var res: TFcResult
  var font: ptr TFcPattern = FcFontMatch(cfg, pat, res.addr)
  echo res
  if not font.isNil:
    var f: ptr TFcChar8 = nil
    if FcPatternGetString(font, FC_FILE, 0, f.addr) == FcResultMatch:
      # we found the font, now print it.
      # This might be a fallback font
      result = $(cast[cstring](f))
      echo result
  FcPatternDestroy(font)
  FcPatternDestroy(pat)
  FcConfigDestroy(cfg)
  FcFini()

echo findFont("noto sans")
