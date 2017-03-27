#  source: https://bitbucket.org/exhu/paulina/src/6f27d4ca90ed?at=default
#  fontconfig/fontconfig/fontconfig.h
#
#  Copyright © 2001 Keith Packard
#
#  Permission to use, copy, modify, distribute, and sell this software and its
#  documentation for any purpose is hereby granted without fee, provided that
#  the above copyright notice appear in all copies and that both that
#  copyright notice and this permission notice appear in supporting
#  documentation, and that the name of the author(s) not be used in
#  advertising or publicity pertaining to distribution of the software without
#  specific, written prior permission.  The authors make no
#  representations about the suitability of this software for any purpose.  It
#  is provided "as is" without express or implied warranty.
#
#  THE AUTHOR(S) DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
#  INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
#  EVENT SHALL THE AUTHOR(S) BE LIABLE FOR ANY SPECIAL, INDIRECT OR
#  CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
#  DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
#  TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
#  PERFORMANCE OF THIS SOFTWARE.
#

when defined(use_pkg_config) or defined(use_pkg_config_static):
    {.pragma: libfontconfig, cdecl.}
    when defined(use_pkg_config_static):
        {.passl: gorge("pkg-config fontconfig --libs --static").}
    else:
        {.passl: gorge("pkg-config fontconfig --libs").}
else:
    when defined(windows):
      const LIB_FONTCONFIG* = "libfontconfig.dll"
    elif defined(macosx):
      const LIB_FONTCONFIG* = "libfontconfig.dylib"
    else:
      const LIB_FONTCONFIG* = "libfontconfig.so(|.1)"
    {.pragma: libfontconfig, cdecl, dynlib: LIB_FONTCONFIG.}

type
  TFcChar8* = cuchar
  TFcChar16* = cushort
  TFcChar32* = cuint
  TFcBool* = cint


converter toPFcChar8*(s: string): ptr TFcChar8 =
    cast[ptr TFcChar8](cstring(s))

#
#  Current Fontconfig version number.  This same number
#  must appear in the fontconfig configure.in file. Yes,
#  it'a a pain to synchronize version numbers like this.
#

const
  FC_MAJOR* = 2
  FC_MINOR* = 10
  FC_REVISION* = 93
  FC_VERSION* = ((FC_MAJOR * 10000) + (FC_MINOR * 100) + (FC_REVISION))

#
#  Current font cache file format version
#  This is appended to the cache files so that multiple
#  versions of the library will peacefully coexist
#
#  Change this value whenever the disk format for the cache file
#  changes in any non-compatible way.  Try to avoid such changes as
#  it means multiple copies of the font information.
#

const
  FC_CACHE_VERSION* = "4"
  FcTrue* = 1
  FcFalse* = 0
  FC_FAMILY* = "family"       # String
  FC_STYLE* = "style"         # String
  FC_SLANT* = "slant"         # Int
  FC_WEIGHT* = "weight"       # Int
  FC_SIZE* = "size"           # Double
  FC_ASPECT* = "aspect"       # Double
  FC_PIXEL_SIZE* = "pixelsize" # Double
  FC_SPACING* = "spacing"     # Int
  FC_FOUNDRY* = "foundry"     # String
  FC_ANTIALIAS* = "antialias" # Bool (depends)
  FC_HINTING* = "hinting"     # Bool (true)
  FC_HINT_STYLE* = "hintstyle" # Int
  FC_VERTICAL_LAYOUT* = "verticallayout" # Bool (false)
  FC_AUTOHINT* = "autohint"   # Bool (false)

# FC_GLOBAL_ADVANCE is deprecated. this is simply ignored on freetype 2.4.5 or later
converter toFcBool*(b: bool): TFcBool =
    if b == true:
        return FcTrue
    return FcFalse


const
  FC_GLOBAL_ADVANCE* = "globaladvance" # Bool (true)
  FC_WIDTH* = "width"         # Int
  FC_FILE* = "file"           # String
  FC_INDEX* = "index"         # Int
  FC_FT_FACE* = "ftface"      # FT_Face
  FC_RASTERIZER* = "rasterizer" # String
  FC_OUTLINE* = "outline"     # Bool
  FC_SCALABLE* = "scalable"   # Bool
  FC_SCALE* = "scale"         # double
  FC_DPI* = "dpi"             # double
  FC_RGBA* = "rgba"           # Int
  FC_MINSPACE* = "minspace"   # Bool use minimum line spacing
  FC_SOURCE* = "source"       # String (deprecated)
  FC_CHARSET* = "charset"     # CharSet
  FC_LANG* = "lang"           # String RFC 3066 langs
  FC_FONTVERSION* = "fontversion" # Int from 'head' table
  FC_FULLNAME* = "fullname"   # String
  FC_FAMILYLANG* = "familylang" # String RFC 3066 langs
  FC_STYLELANG* = "stylelang" # String RFC 3066 langs
  FC_FULLNAMELANG* = "fullnamelang" # String RFC 3066 langs
  FC_CAPABILITY* = "capability" # String
  FC_FONTFORMAT* = "fontformat" # String
  FC_EMBOLDEN* = "embolden"   # Bool - true if emboldening needed
  FC_EMBEDDED_BITMAP* = "embeddedbitmap" # Bool - true to enable embedded bitmaps
  FC_DECORATIVE* = "decorative" # Bool - true if style is a decorative variant
  FC_LCD_FILTER* = "lcdfilter" # Int
  FC_FONT_FEATURES* = "fontfeatures" # String
  FC_NAMELANG* = "namelang"   # String RFC 3866 langs
  FC_PRGNAME* = "prgname"     # String
  FC_HASH* = "hash"           # String
  FC_POSTSCRIPT_NAME* = "postscriptname" # String

# TODO fix for nimrod
##define FC_CACHE_SUFFIX		    ".cache-" FC_CACHE_VERSION
##define FC_DIR_CACHE_FILE	    "fonts.cache-" FC_CACHE_VERSION
##define FC_USER_CACHE_FILE	    ".fonts.cache-" FC_CACHE_VERSION
# Adjust outline rasterizer

const
  FC_CHAR_WIDTH* = "charwidth" # Int
  FC_CHAR_HEIGHT* = "charheight" # Int
  FC_MATRIX* = "matrix"       # FcMatrix
  FC_WEIGHT_THIN*:cint = 0
  FC_WEIGHT_EXTRALIGHT*:cint = 40
  FC_WEIGHT_ULTRALIGHT*:cint = FC_WEIGHT_EXTRALIGHT
  FC_WEIGHT_LIGHT*:cint = 50
  FC_WEIGHT_BOOK*:cint = 75
  FC_WEIGHT_REGULAR*:cint = 80
  FC_WEIGHT_NORMAL*:cint = FC_WEIGHT_REGULAR
  FC_WEIGHT_MEDIUM*:cint = 100
  FC_WEIGHT_DEMIBOLD*:cint = 180
  FC_WEIGHT_SEMIBOLD*:cint = FC_WEIGHT_DEMIBOLD
  FC_WEIGHT_BOLD*:cint = 200
  FC_WEIGHT_EXTRABOLD*:cint = 205
  FC_WEIGHT_ULTRABOLD*:cint = FC_WEIGHT_EXTRABOLD
  FC_WEIGHT_BLACK*:cint = 210
  FC_WEIGHT_HEAVY*:cint = FC_WEIGHT_BLACK
  FC_WEIGHT_EXTRABLACK*:cint = 215
  FC_WEIGHT_ULTRABLACK*:cint = FC_WEIGHT_EXTRABLACK
  FC_SLANT_ROMAN*:cint = 0
  FC_SLANT_ITALIC*:cint = 100
  FC_SLANT_OBLIQUE*:cint = 110
  FC_WIDTH_ULTRACONDENSED*:cint = 50
  FC_WIDTH_EXTRACONDENSED*:cint = 63
  FC_WIDTH_CONDENSED*:cint = 75
  FC_WIDTH_SEMICONDENSED*:cint = 87
  FC_WIDTH_NORMAL*:cint = 100
  FC_WIDTH_SEMIEXPANDED*:cint = 113
  FC_WIDTH_EXPANDED*:cint = 125
  FC_WIDTH_EXTRAEXPANDED*:cint = 150
  FC_WIDTH_ULTRAEXPANDED*:cint = 200
  FC_PROPORTIONAL*:cint = 0
  FC_DUAL*:cint = 90
  FC_MONO*:cint = 100
  FC_CHARCELL*:cint = 110

# sub-pixel order

const
  FC_RGBA_UNKNOWN* = 0
  FC_RGBA_RGB* = 1
  FC_RGBA_BGR* = 2
  FC_RGBA_VRGB* = 3
  FC_RGBA_VBGR* = 4
  FC_RGBA_NONE* = 5

# hinting style

const
  FC_HINT_NONE* = 0
  FC_HINT_SLIGHT* = 1
  FC_HINT_MEDIUM* = 2
  FC_HINT_FULL* = 3

# LCD filter

const
  FC_LCD_NONE* = 0
  FC_LCD_DEFAULT* = 1
  FC_LCD_LIGHT* = 2
  FC_LCD_LEGACY* = 3

type
  TFcType* {.size: sizeof(cint).} = enum
    FcTypeVoid, FcTypeInteger, FcTypeDouble, FcTypeString, FcTypeBool,
    FcTypeMatrix, FcTypeCharSet, FcTypeFTFace, FcTypeLangSet
  TFcMatrix* {.pure, final.} = object
    xx*: cdouble
    xy*: cdouble
    yx*: cdouble
    yy*: cdouble


# TODO fix for nimrod
##define FcMatrixInit(m)	((m)->xx = (m)->yy = 1, \
#			 (m)->xy = (m)->yx = 0)
#
#  A data structure to represent the available glyphs in a font.
#  This is represented as a sparse boolean btree.
#

type
  TFcCharSet* = object
  TFcObjectType* {.pure, final.} = object
    theObject*: cstring
    theType*: TFcType

  TFcConstant* {.pure, final.} = object
    name*: ptr TFcChar8
    theObject*: cstring
    value*: cint

  TFcResult* {.size: sizeof(cint).} = enum
    FcResultMatch, FcResultNoMatch, FcResultTypeMismatch, FcResultNoId,
    FcResultOutOfMemory

  PFcPattern* = ptr TFcPattern
  TFcPattern* = object
  TFcLangSet* = object
  TFcValue* {.pure, final.} = object
    theType*: TFcType         # TODO fix for nimrod
                              #union {
                              # const FcChar8	*s;
                              # int		i;
                              # FcBool		b;
                              #
    d*: cdouble               #
                              # const FcMatrix	*m;
                              # const FcCharSet	*c;
                              # void		*f;
                              # const FcLangSet	*l;
                              #    } u;

  TFcFontSet* {.pure, final.} = object
    nfont*: cint
    sfont*: cint
    fonts*: ptr ptr TFcPattern

  TFcObjectSet* {.pure, final.} = object
    nobject*: cint
    sobject*: cint
    objects*: cstringArray

  TFcMatchKind* {.size: sizeof(cint).} = enum
    FcMatchPattern, FcMatchFont, FcMatchScan
#  TFcLangResult* {.size: sizeof(cint).} = enum
#    FcLangEqual = 0, FcLangDifferentCountry = 1, FcLangDifferentTerritory = 1,
#    FcLangDifferentLang = 2
type TFcLangResult* = cint
const
    FcLangEqual* = 0
    FcLangDifferentCountry* = 1
    FcLangDifferentTerritory* = 1
    FcLangDifferentLang* = 2
type
  TFcSetName* {.size: sizeof(cint).} = enum
    FcSetSystem = 0, FcSetApplication = 1
  TFcAtomic* = object

# fixed for nimrod
##if defined(__cplusplus) || defined(c_plusplus) /* for C++ V2.0 */
##define _FCFUNCPROTOBEGIN extern "C" {	/* do not leave open across includes */
##define _FCFUNCPROTOEND }
##else
##define _FCFUNCPROTOBEGIN
##define _FCFUNCPROTOEND
##endif

type
  TFcEndian* {.size: sizeof(cint).} = enum
    FcEndianBig, FcEndianLittle
  TFcConfig* = object
  TFcFileCache* = object
  TFcBlanks* = object
  TFcStrList* = object
  TFcStrSet* = object
  TFcCache* = object

#_FCFUNCPROTOBEGIN
# fcblanks.c
# fixed for nimrod
#/*FcPublic*/

proc FcBlanksCreate*(): ptr TFcBlanks {.cdecl, importc: "FcBlanksCreate",
                                        libfontconfig.}
#FcPublic

proc FcBlanksDestroy*(b: ptr TFcBlanks) {.cdecl, importc: "FcBlanksDestroy",
    libfontconfig.}
#FcPublic

proc FcBlanksAdd*(b: ptr TFcBlanks; ucs4: TFcChar32): TFcBool {.cdecl,
    importc: "FcBlanksAdd", libfontconfig.}
#FcPublic

proc FcBlanksIsMember*(b: ptr TFcBlanks; ucs4: TFcChar32): TFcBool {.cdecl,
    importc: "FcBlanksIsMember", libfontconfig.}
# fccache.c
#FcPublic

proc FcCacheDir*(c: ptr TFcCache): ptr TFcChar8 {.cdecl, importc: "FcCacheDir",
    libfontconfig.}
#FcPublic

proc FcCacheCopySet*(c: ptr TFcCache): ptr TFcFontSet {.cdecl,
    importc: "FcCacheCopySet", libfontconfig.}
#FcPublic

proc FcCacheSubdir*(c: ptr TFcCache; i: cint): ptr TFcChar8 {.cdecl,
    importc: "FcCacheSubdir", libfontconfig.}
#FcPublic

proc FcCacheNumSubdir*(c: ptr TFcCache): cint {.cdecl,
    importc: "FcCacheNumSubdir", libfontconfig.}
#FcPublic

proc FcCacheNumFont*(c: ptr TFcCache): cint {.cdecl, importc: "FcCacheNumFont",
    libfontconfig.}
#FcPublic

proc FcDirCacheUnlink*(dir: ptr TFcChar8; config: ptr TFcConfig): TFcBool {.
    cdecl, importc: "FcDirCacheUnlink", libfontconfig.}
#FcPublic

proc FcDirCacheValid*(cache_file: ptr TFcChar8): TFcBool {.cdecl,
    importc: "FcDirCacheValid", libfontconfig.}
#FcPublic

proc FcDirCacheClean*(cache_dir: ptr TFcChar8; verbose: TFcBool): TFcBool {.
    cdecl, importc: "FcDirCacheClean", libfontconfig.}
#FcPublic

proc FcCacheCreateTagFile*(config: ptr TFcConfig) {.cdecl,
    importc: "FcCacheCreateTagFile", libfontconfig.}
# fccfg.c
#FcPublic

proc FcConfigHome*(): ptr TFcChar8 {.cdecl, importc: "FcConfigHome",
                                     libfontconfig.}
#FcPublic

proc FcConfigEnableHome*(enable: TFcBool): TFcBool {.cdecl,
    importc: "FcConfigEnableHome", libfontconfig.}
#FcPublic

proc FcConfigFilename*(url: ptr TFcChar8): ptr TFcChar8 {.cdecl,
    importc: "FcConfigFilename", libfontconfig.}
#FcPublic

proc FcConfigCreate*(): ptr TFcConfig {.cdecl, importc: "FcConfigCreate",
                                        libfontconfig.}
#FcPublic

proc FcConfigReference*(config: ptr TFcConfig): ptr TFcConfig {.cdecl,
    importc: "FcConfigReference", libfontconfig.}
#FcPublic

proc FcConfigDestroy*(config: ptr TFcConfig) {.cdecl,
    importc: "FcConfigDestroy", libfontconfig.}
#FcPublic

proc FcConfigSetCurrent*(config: ptr TFcConfig): TFcBool {.cdecl,
    importc: "FcConfigSetCurrent", libfontconfig.}
#FcPublic

proc FcConfigGetCurrent*(): ptr TFcConfig {.cdecl,
    importc: "FcConfigGetCurrent", libfontconfig.}
#FcPublic

proc FcConfigUptoDate*(config: ptr TFcConfig): TFcBool {.cdecl,
    importc: "FcConfigUptoDate", libfontconfig.}
#FcPublic

proc FcConfigBuildFonts*(config: ptr TFcConfig): TFcBool {.cdecl,
    importc: "FcConfigBuildFonts", libfontconfig.}
#FcPublic

proc FcConfigGetFontDirs*(config: ptr TFcConfig): ptr TFcStrList {.cdecl,
    importc: "FcConfigGetFontDirs", libfontconfig.}
#FcPublic

proc FcConfigGetConfigDirs*(config: ptr TFcConfig): ptr TFcStrList {.cdecl,
    importc: "FcConfigGetConfigDirs", libfontconfig.}
#FcPublic

proc FcConfigGetConfigFiles*(config: ptr TFcConfig): ptr TFcStrList {.cdecl,
    importc: "FcConfigGetConfigFiles", libfontconfig.}
#FcPublic

proc FcConfigGetCache*(config: ptr TFcConfig): ptr TFcChar8 {.cdecl,
    importc: "FcConfigGetCache", libfontconfig.}
#FcPublic

proc FcConfigGetBlanks*(config: ptr TFcConfig): ptr TFcBlanks {.cdecl,
    importc: "FcConfigGetBlanks", libfontconfig.}
#FcPublic

proc FcConfigGetCacheDirs*(config: ptr TFcConfig): ptr TFcStrList {.cdecl,
    importc: "FcConfigGetCacheDirs", libfontconfig.}
#FcPublic

proc FcConfigGetRescanInterval*(config: ptr TFcConfig): cint {.cdecl,
    importc: "FcConfigGetRescanInterval", libfontconfig.}
#FcPublic

proc FcConfigSetRescanInterval*(config: ptr TFcConfig; rescanInterval: cint): TFcBool {.
    cdecl, importc: "FcConfigSetRescanInterval", libfontconfig.}
#FcPublic

proc FcConfigGetFonts*(config: ptr TFcConfig; set: TFcSetName): ptr TFcFontSet {.
    cdecl, importc: "FcConfigGetFonts", libfontconfig.}
#FcPublic

proc FcConfigAppFontAddFile*(config: ptr TFcConfig; file: ptr TFcChar8): TFcBool {.
    cdecl, importc: "FcConfigAppFontAddFile", libfontconfig.}
#FcPublic

proc FcConfigAppFontAddDir*(config: ptr TFcConfig; dir: ptr TFcChar8): TFcBool {.
    cdecl, importc: "FcConfigAppFontAddDir", libfontconfig.}
#FcPublic

proc FcConfigAppFontClear*(config: ptr TFcConfig) {.cdecl,
    importc: "FcConfigAppFontClear", libfontconfig.}
#FcPublic

proc FcConfigSubstituteWithPat*(config: ptr TFcConfig; p: ptr TFcPattern;
                                p_pat: ptr TFcPattern; kind: TFcMatchKind): TFcBool {.
    cdecl, importc: "FcConfigSubstituteWithPat", libfontconfig.}
#FcPublic

proc FcConfigSubstitute*(config: ptr TFcConfig; p: ptr TFcPattern;
                         kind: TFcMatchKind): TFcBool {.cdecl,
    importc: "FcConfigSubstitute", libfontconfig.}
#FcPublic

proc FcConfigGetSysRoot*(config: ptr TFcConfig): ptr TFcChar8 {.cdecl,
    importc: "FcConfigGetSysRoot", libfontconfig.}
#FcPublic

proc FcConfigSetSysRoot*(config: ptr TFcConfig; sysroot: ptr TFcChar8) {.cdecl,
    importc: "FcConfigSetSysRoot", libfontconfig.}
# fccharset.c
#FcPublic

proc FcCharSetCreate*(): ptr TFcCharSet {.cdecl, importc: "FcCharSetCreate",
    libfontconfig.}
# deprecated alias for FcCharSetCreate
#FcPublic

proc FcCharSetNew*(): ptr TFcCharSet {.cdecl, importc: "FcCharSetNew",
                                       libfontconfig.}
#FcPublic

proc FcCharSetDestroy*(fcs: ptr TFcCharSet) {.cdecl,
    importc: "FcCharSetDestroy", libfontconfig.}
#FcPublic

proc FcCharSetAddChar*(fcs: ptr TFcCharSet; ucs4: TFcChar32): TFcBool {.cdecl,
    importc: "FcCharSetAddChar", libfontconfig.}
#FcPublic

proc FcCharSetDelChar*(fcs: ptr TFcCharSet; ucs4: TFcChar32): TFcBool {.cdecl,
    importc: "FcCharSetDelChar", libfontconfig.}
#FcPublic

proc FcCharSetCopy*(src: ptr TFcCharSet): ptr TFcCharSet {.cdecl,
    importc: "FcCharSetCopy", libfontconfig.}
#FcPublic

proc FcCharSetEqual*(a: ptr TFcCharSet; b: ptr TFcCharSet): TFcBool {.cdecl,
    importc: "FcCharSetEqual", libfontconfig.}
#FcPublic

proc FcCharSetIntersect*(a: ptr TFcCharSet; b: ptr TFcCharSet): ptr TFcCharSet {.
    cdecl, importc: "FcCharSetIntersect", libfontconfig.}
#FcPublic

proc FcCharSetUnion*(a: ptr TFcCharSet; b: ptr TFcCharSet): ptr TFcCharSet {.
    cdecl, importc: "FcCharSetUnion", libfontconfig.}
#FcPublic

proc FcCharSetSubtract*(a: ptr TFcCharSet; b: ptr TFcCharSet): ptr TFcCharSet {.
    cdecl, importc: "FcCharSetSubtract", libfontconfig.}
#FcPublic

proc FcCharSetMerge*(a: ptr TFcCharSet; b: ptr TFcCharSet; changed: ptr TFcBool): TFcBool {.
    cdecl, importc: "FcCharSetMerge", libfontconfig.}
#FcPublic

proc FcCharSetHasChar*(fcs: ptr TFcCharSet; ucs4: TFcChar32): TFcBool {.cdecl,
    importc: "FcCharSetHasChar", libfontconfig.}
#FcPublic

proc FcCharSetCount*(a: ptr TFcCharSet): TFcChar32 {.cdecl,
    importc: "FcCharSetCount", libfontconfig.}
#FcPublic

proc FcCharSetIntersectCount*(a: ptr TFcCharSet; b: ptr TFcCharSet): TFcChar32 {.
    cdecl, importc: "FcCharSetIntersectCount", libfontconfig.}
#FcPublic

proc FcCharSetSubtractCount*(a: ptr TFcCharSet; b: ptr TFcCharSet): TFcChar32 {.
    cdecl, importc: "FcCharSetSubtractCount", libfontconfig.}
#FcPublic

proc FcCharSetIsSubset*(a: ptr TFcCharSet; b: ptr TFcCharSet): TFcBool {.cdecl,
    importc: "FcCharSetIsSubset", libfontconfig.}
const
  FC_CHARSET_MAP_SIZE* = (256 div 32)
  FC_CHARSET_DONE* = TFcChar32(-1)

#FcPublic

proc FcCharSetFirstPage*(a: ptr TFcCharSet;
                         map: array[0..FC_CHARSET_MAP_SIZE - 1, TFcChar32];
                         next: ptr TFcChar32): TFcChar32 {.cdecl,
    importc: "FcCharSetFirstPage", libfontconfig.}
#FcPublic

proc FcCharSetNextPage*(a: ptr TFcCharSet;
                        map: array[0..FC_CHARSET_MAP_SIZE - 1, TFcChar32];
                        next: ptr TFcChar32): TFcChar32 {.cdecl,
    importc: "FcCharSetNextPage", libfontconfig.}
#
#  old coverage API, rather hard to use correctly
#
#FcPublic

proc FcCharSetCoverage*(a: ptr TFcCharSet; page: TFcChar32;
                        result: ptr TFcChar32): TFcChar32 {.cdecl,
    importc: "FcCharSetCoverage", libfontconfig.}
# fcdbg.c
#FcPublic

proc FcValuePrint*(v: TFcValue) {.cdecl, importc: "FcValuePrint",
                                  libfontconfig.}
#FcPublic

proc FcPatternPrint*(p: ptr TFcPattern) {.cdecl, importc: "FcPatternPrint",
    libfontconfig.}
#FcPublic

proc FcFontSetPrint*(s: ptr TFcFontSet) {.cdecl, importc: "FcFontSetPrint",
    libfontconfig.}
# fcdefault.c
#FcPublic

proc FcGetDefaultLangs*(): ptr TFcStrSet {.cdecl, importc: "FcGetDefaultLangs",
    libfontconfig.}
#FcPublic

proc FcDefaultSubstitute*(pattern: ptr TFcPattern) {.cdecl,
    importc: "FcDefaultSubstitute", libfontconfig.}
# fcdir.c
#FcPublic

proc FcFileIsDir*(file: ptr TFcChar8): TFcBool {.cdecl, importc: "FcFileIsDir",
    libfontconfig.}
#FcPublic

proc FcFileScan*(set: ptr TFcFontSet; dirs: ptr TFcStrSet;
                 cache: ptr TFcFileCache; blanks: ptr TFcBlanks;
                 file: ptr TFcChar8; force: TFcBool): TFcBool {.cdecl,
    importc: "FcFileScan", libfontconfig.}
#FcPublic

proc FcDirScan*(set: ptr TFcFontSet; dirs: ptr TFcStrSet;
                cache: ptr TFcFileCache; blanks: ptr TFcBlanks;
                dir: ptr TFcChar8; force: TFcBool): TFcBool {.cdecl,
    importc: "FcDirScan", libfontconfig.}
#FcPublic

proc FcDirSave*(set: ptr TFcFontSet; dirs: ptr TFcStrSet; dir: ptr TFcChar8): TFcBool {.
    cdecl, importc: "FcDirSave", libfontconfig.}
#FcPublic

proc FcDirCacheLoad*(dir: ptr TFcChar8; config: ptr TFcConfig;
                     cache_file: ptr ptr TFcChar8): ptr TFcCache {.cdecl,
    importc: "FcDirCacheLoad", libfontconfig.}
#FcPublic

proc FcDirCacheRead*(dir: ptr TFcChar8; force: TFcBool; config: ptr TFcConfig): ptr TFcCache {.
    cdecl, importc: "FcDirCacheRead", libfontconfig.}
#FcPublic

# TODO fix for nimrod
#proc FcDirCacheLoadFile*(cache_file: ptr TFcChar8; file_stat: ptr stat): ptr TFcCache {.
#    cdecl, importc: "FcDirCacheLoadFile", libfontconfig.}
#FcPublic

proc FcDirCacheUnload*(cache: ptr TFcCache) {.cdecl,
    importc: "FcDirCacheUnload", libfontconfig.}
# fcfreetype.c
#FcPublic

proc FcFreeTypeQuery*(file: ptr TFcChar8; id: cint; blanks: ptr TFcBlanks;
                      count: ptr cint): ptr TFcPattern {.cdecl,
    importc: "FcFreeTypeQuery", libfontconfig.}
# fcfs.c
#FcPublic

proc FcFontSetCreate*(): ptr TFcFontSet {.cdecl, importc: "FcFontSetCreate",
    libfontconfig.}
#FcPublic

proc FcFontSetDestroy*(s: ptr TFcFontSet) {.cdecl, importc: "FcFontSetDestroy",
    libfontconfig.}
#FcPublic

proc FcFontSetAdd*(s: ptr TFcFontSet; font: ptr TFcPattern): TFcBool {.cdecl,
    importc: "FcFontSetAdd", libfontconfig.}
# fcinit.c
#FcPublic

proc FcInitLoadConfig*(): ptr TFcConfig {.cdecl, importc: "FcInitLoadConfig",
    libfontconfig.}
#FcPublic

proc FcInitLoadConfigAndFonts*(): ptr TFcConfig {.cdecl,
    importc: "FcInitLoadConfigAndFonts", libfontconfig.}
#FcPublic

proc FcInit*(): TFcBool {.cdecl, importc: "FcInit", libfontconfig.}
#FcPublic

proc FcFini*() {.cdecl, importc: "FcFini", libfontconfig.}
#FcPublic

proc FcGetVersion*(): cint {.cdecl, importc: "FcGetVersion", libfontconfig.}
#FcPublic

proc FcInitReinitialize*(): TFcBool {.cdecl, importc: "FcInitReinitialize",
                                      libfontconfig.}
#FcPublic

proc FcInitBringUptoDate*(): TFcBool {.cdecl, importc: "FcInitBringUptoDate",
                                       libfontconfig.}
# fclang.c
#FcPublic

proc FcGetLangs*(): ptr TFcStrSet {.cdecl, importc: "FcGetLangs",
                                    libfontconfig.}
#FcPublic

proc FcLangNormalize*(lang: ptr TFcChar8): ptr TFcChar8 {.cdecl,
    importc: "FcLangNormalize", libfontconfig.}
#FcPublic

proc FcLangGetCharSet*(lang: ptr TFcChar8): ptr TFcCharSet {.cdecl,
    importc: "FcLangGetCharSet", libfontconfig.}
#FcPublic

proc FcLangSetCreate*(): ptr TFcLangSet {.cdecl, importc: "FcLangSetCreate",
    libfontconfig.}
#FcPublic

proc FcLangSetDestroy*(ls: ptr TFcLangSet) {.cdecl, importc: "FcLangSetDestroy",
    libfontconfig.}
#FcPublic

proc FcLangSetCopy*(ls: ptr TFcLangSet): ptr TFcLangSet {.cdecl,
    importc: "FcLangSetCopy", libfontconfig.}
#FcPublic

proc FcLangSetAdd*(ls: ptr TFcLangSet; lang: ptr TFcChar8): TFcBool {.cdecl,
    importc: "FcLangSetAdd", libfontconfig.}
#FcPublic

proc FcLangSetDel*(ls: ptr TFcLangSet; lang: ptr TFcChar8): TFcBool {.cdecl,
    importc: "FcLangSetDel", libfontconfig.}
#FcPublic

proc FcLangSetHasLang*(ls: ptr TFcLangSet; lang: ptr TFcChar8): TFcLangResult {.
    cdecl, importc: "FcLangSetHasLang", libfontconfig.}
#FcPublic

proc FcLangSetCompare*(lsa: ptr TFcLangSet; lsb: ptr TFcLangSet): TFcLangResult {.
    cdecl, importc: "FcLangSetCompare", libfontconfig.}
#FcPublic

proc FcLangSetContains*(lsa: ptr TFcLangSet; lsb: ptr TFcLangSet): TFcBool {.
    cdecl, importc: "FcLangSetContains", libfontconfig.}
#FcPublic

proc FcLangSetEqual*(lsa: ptr TFcLangSet; lsb: ptr TFcLangSet): TFcBool {.cdecl,
    importc: "FcLangSetEqual", libfontconfig.}
#FcPublic

proc FcLangSetHash*(ls: ptr TFcLangSet): TFcChar32 {.cdecl,
    importc: "FcLangSetHash", libfontconfig.}
#FcPublic

proc FcLangSetGetLangs*(ls: ptr TFcLangSet): ptr TFcStrSet {.cdecl,
    importc: "FcLangSetGetLangs", libfontconfig.}
#FcPublic

proc FcLangSetUnion*(a: ptr TFcLangSet; b: ptr TFcLangSet): ptr TFcLangSet {.
    cdecl, importc: "FcLangSetUnion", libfontconfig.}
#FcPublic

proc FcLangSetSubtract*(a: ptr TFcLangSet; b: ptr TFcLangSet): ptr TFcLangSet {.
    cdecl, importc: "FcLangSetSubtract", libfontconfig.}
# fclist.c
#FcPublic

proc FcObjectSetCreate*(): ptr TFcObjectSet {.cdecl,
    importc: "FcObjectSetCreate", libfontconfig.}
#FcPublic

proc FcObjectSetAdd*(os: ptr TFcObjectSet; theObject: cstring): TFcBool {.cdecl,
    importc: "FcObjectSetAdd", libfontconfig.}
#FcPublic

proc FcObjectSetDestroy*(os: ptr TFcObjectSet) {.cdecl,
    importc: "FcObjectSetDestroy", libfontconfig.}
#FcPublic

# TODO fix for nimrod
#proc FcObjectSetVaBuild*(first: cstring; va: va_list): ptr TFcObjectSet {.cdecl,
#    importc: "FcObjectSetVaBuild", libfontconfig.}
#FcPublic

proc FcObjectSetBuild*(first: cstring): ptr TFcObjectSet {.varargs, cdecl,
    importc: "FcObjectSetBuild", libfontconfig.}
  #FC_ATTRIBUTE_SENTINEL(0)
#FcPublic

proc FcFontSetList*(config: ptr TFcConfig; sets: ptr ptr TFcFontSet;
                    nsets: cint; p: ptr TFcPattern; os: ptr TFcObjectSet): ptr TFcFontSet {.
    cdecl, importc: "FcFontSetList", libfontconfig.}
#FcPublic

proc FcFontList*(config: ptr TFcConfig; p: ptr TFcPattern; os: ptr TFcObjectSet): ptr TFcFontSet {.
    cdecl, importc: "FcFontList", libfontconfig.}
# fcatomic.c
#FcPublic

proc FcAtomicCreate*(file: ptr TFcChar8): ptr TFcAtomic {.cdecl,
    importc: "FcAtomicCreate", libfontconfig.}
#FcPublic

proc FcAtomicLock*(theAtomic: ptr TFcAtomic): TFcBool {.cdecl,
    importc: "FcAtomicLock", libfontconfig.}
#FcPublic

proc FcAtomicNewFile*(theAtomic: ptr TFcAtomic): ptr TFcChar8 {.cdecl,
    importc: "FcAtomicNewFile", libfontconfig.}
#FcPublic

proc FcAtomicOrigFile*(theAtomic: ptr TFcAtomic): ptr TFcChar8 {.cdecl,
    importc: "FcAtomicOrigFile", libfontconfig.}
#FcPublic

proc FcAtomicReplaceOrig*(theAtomic: ptr TFcAtomic): TFcBool {.cdecl,
    importc: "FcAtomicReplaceOrig", libfontconfig.}
#FcPublic

proc FcAtomicDeleteNew*(theAtomic: ptr TFcAtomic) {.cdecl,
    importc: "FcAtomicDeleteNew", libfontconfig.}
#FcPublic

proc FcAtomicUnlock*(theAtomic: ptr TFcAtomic) {.cdecl,
    importc: "FcAtomicUnlock", libfontconfig.}
#FcPublic

proc FcAtomicDestroy*(theAtomic: ptr TFcAtomic) {.cdecl,
    importc: "FcAtomicDestroy", libfontconfig.}
# fcmatch.c
#FcPublic

proc FcFontSetMatch*(config: ptr TFcConfig; sets: ptr ptr TFcFontSet;
                     nsets: cint; p: ptr TFcPattern; result: ptr TFcResult): ptr TFcPattern {.
    cdecl, importc: "FcFontSetMatch", libfontconfig.}
#FcPublic

proc FcFontMatch*(config: ptr TFcConfig; p: ptr TFcPattern;
                  result: ptr TFcResult): ptr TFcPattern {.cdecl,
    importc: "FcFontMatch", libfontconfig.}
#FcPublic

proc FcFontRenderPrepare*(config: ptr TFcConfig; pat: ptr TFcPattern;
                          font: ptr TFcPattern): ptr TFcPattern {.cdecl,
    importc: "FcFontRenderPrepare", libfontconfig.}
#FcPublic

proc FcFontSetSort*(config: ptr TFcConfig; sets: ptr ptr TFcFontSet;
                    nsets: cint; p: ptr TFcPattern; trim: TFcBool;
                    csp: ptr ptr TFcCharSet; result: ptr TFcResult): ptr TFcFontSet {.
    cdecl, importc: "FcFontSetSort", libfontconfig.}
#FcPublic

proc FcFontSort*(config: ptr TFcConfig; p: ptr TFcPattern; trim: TFcBool;
                 csp: ptr ptr TFcCharSet; result: ptr TFcResult): ptr TFcFontSet {.
    cdecl, importc: "FcFontSort", libfontconfig.}
#FcPublic

proc FcFontSetSortDestroy*(fs: ptr TFcFontSet) {.cdecl,
    importc: "FcFontSetSortDestroy", libfontconfig.}
# fcmatrix.c
#FcPublic

proc FcMatrixCopy*(mat: ptr TFcMatrix): ptr TFcMatrix {.cdecl,
    importc: "FcMatrixCopy", libfontconfig.}
#FcPublic

proc FcMatrixEqual*(mat1: ptr TFcMatrix; mat2: ptr TFcMatrix): TFcBool {.cdecl,
    importc: "FcMatrixEqual", libfontconfig.}
#FcPublic

proc FcMatrixMultiply*(result: ptr TFcMatrix; a: ptr TFcMatrix; b: ptr TFcMatrix) {.
    cdecl, importc: "FcMatrixMultiply", libfontconfig.}
#FcPublic

proc FcMatrixRotate*(m: ptr TFcMatrix; c: cdouble; s: cdouble) {.cdecl,
    importc: "FcMatrixRotate", libfontconfig.}
#FcPublic

proc FcMatrixScale*(m: ptr TFcMatrix; sx: cdouble; sy: cdouble) {.cdecl,
    importc: "FcMatrixScale", libfontconfig.}
#FcPublic

proc FcMatrixShear*(m: ptr TFcMatrix; sh: cdouble; sv: cdouble) {.cdecl,
    importc: "FcMatrixShear", libfontconfig.}
# fcname.c
# Deprecated.  Does nothing.  Returns FcFalse.
#FcPublic

proc FcNameRegisterObjectTypes*(types: ptr TFcObjectType; ntype: cint): TFcBool {.
    cdecl, importc: "FcNameRegisterObjectTypes", libfontconfig.}
# Deprecated.  Does nothing.  Returns FcFalse.
#FcPublic

proc FcNameUnregisterObjectTypes*(types: ptr TFcObjectType; ntype: cint): TFcBool {.
    cdecl, importc: "FcNameUnregisterObjectTypes", libfontconfig.}
#FcPublic

proc FcNameGetObjectType*(theObject: cstring): ptr TFcObjectType {.cdecl,
    importc: "FcNameGetObjectType", libfontconfig.}
# Deprecated.  Does nothing.  Returns FcFalse.
#FcPublic

proc FcNameRegisterConstants*(consts: ptr TFcConstant; nconsts: cint): TFcBool {.
    cdecl, importc: "FcNameRegisterConstants", libfontconfig.}
# Deprecated.  Does nothing.  Returns FcFalse.
#FcPublic

proc FcNameUnregisterConstants*(consts: ptr TFcConstant; nconsts: cint): TFcBool {.
    cdecl, importc: "FcNameUnregisterConstants", libfontconfig.}
#FcPublic

proc FcNameGetConstant*(string: ptr TFcChar8): ptr TFcConstant {.cdecl,
    importc: "FcNameGetConstant", libfontconfig.}
#FcPublic

proc FcNameConstant*(string: ptr TFcChar8; result: ptr cint): TFcBool {.cdecl,
    importc: "FcNameConstant", libfontconfig.}
#FcPublic

proc FcNameParse*(name: ptr TFcChar8): ptr TFcPattern {.cdecl,
    importc: "FcNameParse", libfontconfig.}
#FcPublic

proc FcNameUnparse*(pat: ptr TFcPattern): ptr TFcChar8 {.cdecl,
    importc: "FcNameUnparse", libfontconfig.}
# fcpat.c
#FcPublic

proc FcPatternCreate*(): ptr TFcPattern {.cdecl, importc: "FcPatternCreate",
    libfontconfig.}
#FcPublic

proc FcPatternDuplicate*(p: ptr TFcPattern): ptr TFcPattern {.cdecl,
    importc: "FcPatternDuplicate", libfontconfig.}
#FcPublic

proc FcPatternReference*(p: ptr TFcPattern) {.cdecl,
    importc: "FcPatternReference", libfontconfig.}
#FcPublic

proc FcPatternFilter*(p: ptr TFcPattern; os: ptr TFcObjectSet): ptr TFcPattern {.
    cdecl, importc: "FcPatternFilter", libfontconfig.}
#FcPublic

proc FcValueDestroy*(v: TFcValue) {.cdecl, importc: "FcValueDestroy",
                                    libfontconfig.}
#FcPublic

proc FcValueEqual*(va: TFcValue; vb: TFcValue): TFcBool {.cdecl,
    importc: "FcValueEqual", libfontconfig.}
#FcPublic

proc FcValueSave*(v: TFcValue): TFcValue {.cdecl, importc: "FcValueSave",
    libfontconfig.}
#FcPublic

proc FcPatternDestroy*(p: ptr TFcPattern) {.cdecl, importc: "FcPatternDestroy",
    libfontconfig.}
#FcPublic

proc FcPatternEqual*(pa: ptr TFcPattern; pb: ptr TFcPattern): TFcBool {.cdecl,
    importc: "FcPatternEqual", libfontconfig.}
#FcPublic

proc FcPatternEqualSubset*(pa: ptr TFcPattern; pb: ptr TFcPattern;
                           os: ptr TFcObjectSet): TFcBool {.cdecl,
    importc: "FcPatternEqualSubset", libfontconfig.}
#FcPublic

proc FcPatternHash*(p: ptr TFcPattern): TFcChar32 {.cdecl,
    importc: "FcPatternHash", libfontconfig.}
#FcPublic

proc FcPatternAdd*(p: ptr TFcPattern; theObject: cstring; value: TFcValue;
                   append: TFcBool): TFcBool {.cdecl, importc: "FcPatternAdd",
    libfontconfig.}
#FcPublic

proc FcPatternAddWeak*(p: ptr TFcPattern; theObject: cstring; value: TFcValue;
                       append: TFcBool): TFcBool {.cdecl,
    importc: "FcPatternAddWeak", libfontconfig.}
#FcPublic

proc FcPatternGet*(p: ptr TFcPattern; theObject: cstring; id: cint;
                   v: ptr TFcValue): TFcResult {.cdecl, importc: "FcPatternGet",
    libfontconfig.}
#FcPublic

proc FcPatternDel*(p: ptr TFcPattern; theObject: cstring): TFcBool {.cdecl,
    importc: "FcPatternDel", libfontconfig.}
#FcPublic

proc FcPatternRemove*(p: ptr TFcPattern; theObject: cstring; id: cint): TFcBool {.
    cdecl, importc: "FcPatternRemove", libfontconfig.}
#FcPublic

proc FcPatternAddInteger*(p: ptr TFcPattern; theObject: cstring; i: cint): TFcBool {.
    cdecl, importc: "FcPatternAddInteger", libfontconfig.}
#FcPublic

proc FcPatternAddDouble*(p: ptr TFcPattern; theObject: cstring; d: cdouble): TFcBool {.
    cdecl, importc: "FcPatternAddDouble", libfontconfig.}
#FcPublic

proc FcPatternAddString*(p: ptr TFcPattern; theObject: cstring; s: ptr TFcChar8): TFcBool {.
    cdecl, importc: "FcPatternAddString", libfontconfig.}
#FcPublic

proc FcPatternAddMatrix*(p: ptr TFcPattern; theObject: cstring; s: ptr TFcMatrix): TFcBool {.
    cdecl, importc: "FcPatternAddMatrix", libfontconfig.}
#FcPublic

proc FcPatternAddCharSet*(p: ptr TFcPattern; theObject: cstring;
                          c: ptr TFcCharSet): TFcBool {.cdecl,
    importc: "FcPatternAddCharSet", libfontconfig.}
#FcPublic

proc FcPatternAddBool*(p: ptr TFcPattern; theObject: cstring; b: TFcBool): TFcBool {.
    cdecl, importc: "FcPatternAddBool", libfontconfig.}
#FcPublic

proc FcPatternAddLangSet*(p: ptr TFcPattern; theObject: cstring;
                          ls: ptr TFcLangSet): TFcBool {.cdecl,
    importc: "FcPatternAddLangSet", libfontconfig.}
#FcPublic

proc FcPatternGetInteger*(p: ptr TFcPattern; theObject: cstring; n: cint;
                          i: ptr cint): TFcResult {.cdecl,
    importc: "FcPatternGetInteger", libfontconfig.}
#FcPublic

proc FcPatternGetDouble*(p: ptr TFcPattern; theObject: cstring; n: cint;
                         d: ptr cdouble): TFcResult {.cdecl,
    importc: "FcPatternGetDouble", libfontconfig.}
#FcPublic

proc FcPatternGetString*(p: ptr TFcPattern; theObject: cstring; n: cint;
                         s: ptr ptr TFcChar8): TFcResult {.cdecl,
    importc: "FcPatternGetString", libfontconfig.}
#FcPublic

proc FcPatternGetMatrix*(p: ptr TFcPattern; theObject: cstring; n: cint;
                         s: ptr ptr TFcMatrix): TFcResult {.cdecl,
    importc: "FcPatternGetMatrix", libfontconfig.}
#FcPublic

proc FcPatternGetCharSet*(p: ptr TFcPattern; theObject: cstring; n: cint;
                          c: ptr ptr TFcCharSet): TFcResult {.cdecl,
    importc: "FcPatternGetCharSet", libfontconfig.}
#FcPublic

proc FcPatternGetBool*(p: ptr TFcPattern; theObject: cstring; n: cint;
                       b: ptr TFcBool): TFcResult {.cdecl,
    importc: "FcPatternGetBool", libfontconfig.}
#FcPublic

proc FcPatternGetLangSet*(p: ptr TFcPattern; theObject: cstring; n: cint;
                          ls: ptr ptr TFcLangSet): TFcResult {.cdecl,
    importc: "FcPatternGetLangSet", libfontconfig.}
#FcPublic

# TODO fix for nimrod
#proc FcPatternVaBuild*(p: ptr TFcPattern; va: va_list): ptr TFcPattern {.cdecl,
#    importc: "FcPatternVaBuild", libfontconfig.}
#FcPublic

proc FcPatternBuild*(p: ptr TFcPattern): ptr TFcPattern {.varargs, cdecl,
    importc: "FcPatternBuild", libfontconfig.}
  #FC_ATTRIBUTE_SENTINEL(0)
#FcPublic

proc FcPatternFormat*(pat: ptr TFcPattern; format: ptr TFcChar8): ptr TFcChar8 {.
    cdecl, importc: "FcPatternFormat", libfontconfig.}
# fcstr.c
#FcPublic

proc FcStrCopy*(s: ptr TFcChar8): ptr TFcChar8 {.cdecl, importc: "FcStrCopy",
    libfontconfig.}
#FcPublic

proc FcStrCopyFilename*(s: ptr TFcChar8): ptr TFcChar8 {.cdecl,
    importc: "FcStrCopyFilename", libfontconfig.}
#FcPublic

proc FcStrPlus*(s1: ptr TFcChar8; s2: ptr TFcChar8): ptr TFcChar8 {.cdecl,
    importc: "FcStrPlus", libfontconfig.}
#FcPublic

proc FcStrFree*(s: ptr TFcChar8) {.cdecl, importc: "FcStrFree",
                                   libfontconfig.}
# These are ASCII only, suitable only for pattern element names

template FcIsUpper*(c: expr): expr =
  ((0o000000000101 <= (c) and (c) <= 0o000000000132))

template FcIsLower*(c: expr): expr =
  ((0o000000000141 <= (c) and (c) <= 0o000000000172))

template FcToLower*(c: expr): expr =
  (if FcIsUpper(c): (c) - 0o000000000101 + 0o000000000141 else: (c))

#FcPublic

proc FcStrDowncase*(s: ptr TFcChar8): ptr TFcChar8 {.cdecl,
    importc: "FcStrDowncase", libfontconfig.}
#FcPublic

proc FcStrCmpIgnoreCase*(s1: ptr TFcChar8; s2: ptr TFcChar8): cint {.cdecl,
    importc: "FcStrCmpIgnoreCase", libfontconfig.}
#FcPublic

proc FcStrCmp*(s1: ptr TFcChar8; s2: ptr TFcChar8): cint {.cdecl,
    importc: "FcStrCmp", libfontconfig.}
#FcPublic

proc FcStrStrIgnoreCase*(s1: ptr TFcChar8; s2: ptr TFcChar8): ptr TFcChar8 {.
    cdecl, importc: "FcStrStrIgnoreCase", libfontconfig.}
#FcPublic

proc FcStrStr*(s1: ptr TFcChar8; s2: ptr TFcChar8): ptr TFcChar8 {.cdecl,
    importc: "FcStrStr", libfontconfig.}
#FcPublic

proc FcUtf8ToUcs4*(src_orig: ptr TFcChar8; dst: ptr TFcChar32; len: cint): cint {.
    cdecl, importc: "FcUtf8ToUcs4", libfontconfig.}
#FcPublic

proc FcUtf8Len*(string: ptr TFcChar8; len: cint; nchar: ptr cint;
                wchar: ptr cint): TFcBool {.cdecl, importc: "FcUtf8Len",
    libfontconfig.}
const
  FC_UTF8_MAX_LEN* = 6

#FcPublic

proc FcUcs4ToUtf8*(ucs4: TFcChar32;
                   dest: array[0..FC_UTF8_MAX_LEN - 1, TFcChar8]): cint {.cdecl,
    importc: "FcUcs4ToUtf8", libfontconfig.}
#FcPublic

proc FcUtf16ToUcs4*(src_orig: ptr TFcChar8; endian: TFcEndian;
                    dst: ptr TFcChar32; len: cint): cint {.cdecl,
    importc: "FcUtf16ToUcs4", libfontconfig.}
# in bytes
#FcPublic

proc FcUtf16Len*(string: ptr TFcChar8; endian: TFcEndian; len: cint;
                 nchar: ptr cint; wchar: ptr cint): TFcBool {.cdecl,
    importc: "FcUtf16Len", libfontconfig.}
  # in bytes
#FcPublic

proc FcStrDirname*(file: ptr TFcChar8): ptr TFcChar8 {.cdecl,
    importc: "FcStrDirname", libfontconfig.}
#FcPublic

proc FcStrBasename*(file: ptr TFcChar8): ptr TFcChar8 {.cdecl,
    importc: "FcStrBasename", libfontconfig.}
#FcPublic

proc FcStrSetCreate*(): ptr TFcStrSet {.cdecl, importc: "FcStrSetCreate",
                                        libfontconfig.}
#FcPublic

proc FcStrSetMember*(set: ptr TFcStrSet; s: ptr TFcChar8): TFcBool {.cdecl,
    importc: "FcStrSetMember", libfontconfig.}
#FcPublic

proc FcStrSetEqual*(sa: ptr TFcStrSet; sb: ptr TFcStrSet): TFcBool {.cdecl,
    importc: "FcStrSetEqual", libfontconfig.}
#FcPublic

proc FcStrSetAdd*(set: ptr TFcStrSet; s: ptr TFcChar8): TFcBool {.cdecl,
    importc: "FcStrSetAdd", libfontconfig.}
#FcPublic

proc FcStrSetAddFilename*(set: ptr TFcStrSet; s: ptr TFcChar8): TFcBool {.cdecl,
    importc: "FcStrSetAddFilename", libfontconfig.}
#FcPublic

proc FcStrSetDel*(set: ptr TFcStrSet; s: ptr TFcChar8): TFcBool {.cdecl,
    importc: "FcStrSetDel", libfontconfig.}
#FcPublic

proc FcStrSetDestroy*(set: ptr TFcStrSet) {.cdecl, importc: "FcStrSetDestroy",
    libfontconfig.}
#FcPublic

proc FcStrListCreate*(set: ptr TFcStrSet): ptr TFcStrList {.cdecl,
    importc: "FcStrListCreate", libfontconfig.}
#FcPublic

proc FcStrListNext*(list: ptr TFcStrList): ptr TFcChar8 {.cdecl,
    importc: "FcStrListNext", libfontconfig.}
#FcPublic

proc FcStrListDone*(list: ptr TFcStrList) {.cdecl, importc: "FcStrListDone",
    libfontconfig.}
# fcxml.c
#FcPublic

proc FcConfigParseAndLoad*(config: ptr TFcConfig; file: ptr TFcChar8;
                           complain: TFcBool): TFcBool {.cdecl,
    importc: "FcConfigParseAndLoad", libfontconfig.}
#_FCFUNCPROTOEND

##ifndef _FCINT_H_
#
#  Deprecated functions are placed here to help users fix their code without
#  digging through documentation
#
#
##define FcConfigGetRescanInverval   FcConfigGetRescanInverval_REPLACE_BY_FcConfigGetRescanInterval
##define FcConfigSetRescanInverval   FcConfigSetRescanInverval_REPLACE_BY_FcConfigSetRescanInterval
#
##endif
##endif /* _FONTCONFIG_H_ */
