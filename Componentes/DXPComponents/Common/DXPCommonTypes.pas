unit DXPCommonTypes;

interface

type
{ TDXPBoundLines }
  TDXPBoundLines = set of (
    blLeft,                             // left line
    blTop,                              // top line
    blRight,                            // right line
    blBottom                            // bottom line
  );

{ TDXPControlStyle }
  TDXPControlStyle = set of (
    csRedrawCaptionChanged,             // (default)
    csRedrawBorderChanged,              //
    csRedrawEnabledChanged,             // (default)
    csRedrawFocusedChanged,             // (default)
    csRedrawMouseDown,                  // (default)
    csRedrawMouseEnter,                 // (default)
    csRedrawMouseLeave,                 // (default)
    csRedrawMouseMove,                  //
    csRedrawMouseUp,                    // (default)
    csRedrawParentColorChanged,         // (default)
    csRedrawParentFontChanged,          //
    csRedrawPosChanged,                 //
    csRedrawResized                     //
  );

{ TDXPDrawState }
  TDXPDrawState = set of (
    dsDefault,                          // default
    dsHighlight,                        // highlighted
    dsClicked,                          // clicked
    dsFocused                           // focused
  );

{ TDXPGlyphLayout }
  TDXPGlyphLayout = (
    glBottom,                           // bottom glyph
    glCenter,                           // centered glyph
    glTop                               // top glyph
  );

{ TDXPTheme }
  TDXPTheme = (
    WindowsXP,                          // WindowsXP theme
    OfficeXP                            // OfficeXP theme
  );

implementation

end.
