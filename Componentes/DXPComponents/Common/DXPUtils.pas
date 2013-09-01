unit DXPUtils;

interface

uses
  Forms, Windows, Controls, StdCtrls, Graphics, DXPCommonTypes,
  DXPConsts, Types, Classes, PngImage;

type
  TOption = ( opRequired, opPrimaryKey, opCompleteZeros );

procedure ShowMsgInformation(const aMsg: string);
function TryFocus(aWinControl: TWinControl): boolean;
function MethodsEqual(const aMethod1, aMethod2: TMethod): boolean;
procedure DrawLine(const aCanvas: TCanvas; const x1, y1, x2, y2: integer);
procedure ConvertToGray2(aGraphic: TGraphic);
procedure ColorizeBitmap(aBitmap: TBitmap; const aColor: TColor);
//
// { begin animal }
procedure AdjustBoundRect(const BorderWidth: Byte;
  const ShowBoundLines: Boolean; const BoundLines: TDXPBoundLines;
  var Rect: TRect);
//
procedure DrawBoundLines(const aCanvas: TCanvas; const aBoundLines: TDXPBoundLines;
  const aColor: TColor; const Rect: TRect);
//
procedure RenderText(const aParent: TControl; const aCanvas: TCanvas;
  aText: string; const aFont: TFont; const aEnabled, aShowAccelChar: boolean;
  var Rect: TRect; Flags: integer);
//
procedure Frame3d(const aCanvas: TCanvas; const Rect: TRect;
  const TopColor, BottomColor: TColor; const Swapped: boolean = false);
//
procedure SetDrawFlags(const aAlignment: TAlignment; const aWordWrap: boolean;
  var Flags: Integer);
//
procedure PlaceText(const aParent: TControl; const aCanvas: TCanvas;
  const aText: string; const aFont: TFont; const aEnabled, aShowAccelChar: boolean;
  const aAlignment: TAlignment; const aWordWrap: boolean; var Rect: TRect);
//{ end animal }
//

implementation

procedure ShowMsgInformation(const aMsg: string);
begin
  Application.MessageBox( PWideChar( aMsg ), PWideChar( Application.Title ), MB_OK + MB_ICONINFORMATION );
end;

function TryFocus(aWinControl: TWinControl): boolean;
begin
  Result := false;
  //
  try
    if ( aWinControl is TCustomEdit ) and ( TCustomEdit( aWinControl ) ).ReadOnly then
      Exit;
    //
    aWinControl.SetFocus;
    Result := true;
  except
    { Aqui um mudinho, mas está sobe controle!! :-) ( Araújo ) }
  end;
end;

function MethodsEqual(const aMethod1, aMethod2: TMethod): boolean;
begin
  Result := ( aMethod1.Code = aMethod2.Code ) and ( aMethod1.Data = aMethod2.Data );
end;

procedure DrawLine(const aCanvas: TCanvas; const x1, y1, x2, y2: integer);
begin
  aCanvas.MoveTo( x1, y1 );
  aCanvas.LineTo( x2, y2 );
end;

procedure AdjustBoundRect(const BorderWidth: Byte;
  const ShowBoundLines: Boolean; const BoundLines: TDXPBoundLines;
  var Rect: TRect);
begin
  InflateRect( Rect, -BorderWidth, -BorderWidth );
  //
  if not( ShowBoundLines ) then
    Exit;
  //
  if blLeft in BoundLines then
    Inc( Rect.Left );
  //
  if blRight in BoundLines then
    Dec( Rect.Right );
  //
  if blTop in BoundLines then
    Inc( Rect.Top );
  //
  if blBottom in BoundLines then
    Dec( Rect.Bottom );
end;

procedure DrawBoundLines(const aCanvas: TCanvas; const aBoundLines: TDXPBoundLines;
  const aColor: TColor; const Rect: TRect);
begin
  aCanvas.Pen.Color := AColor;
  aCanvas.Pen.Style := psSolid;
  //
  if blLeft in aBoundLines then
    DrawLine( aCanvas, Rect.Left, Rect.Top, Rect.Left, Rect.Bottom - 1 );
  //
  if blTop in aBoundLines then
    DrawLine( aCanvas, Rect.Left, Rect.Top, Rect.Right, Rect.Top );
  //
  if blRight in aBoundLines then
    DrawLine( aCanvas, Rect.Right - 1, Rect.Top, Rect.Right - 1, Rect.Bottom - 1 );
  //
  if blBottom in aBoundLines then
    DrawLine( aCanvas, Rect.Top, Rect.Bottom - 1, Rect.Right, Rect.Bottom - 1 );
end;

procedure ConvertToGray2(aGraphic: TGraphic);
var
  x, y, c: integer;
  PxlColor: TColor;
  Can: TCanvas;
begin
  if ( aGraphic is TBitmap ) then
    Can := TBitmap( aGraphic ).Canvas
  else
    if ( aGraphic is TPngImage ) then
      Can := TPngImage( aGraphic ).Canvas
  else
    Exit;
  //
  for x := 0 to aGraphic.Width - 1 do
    for y := 0 to aGraphic.Height - 1 do
    begin
      PxlColor := ColorToRGB( Can.Pixels[x, y] );
      c := ( PxlColor shr 16 + ( ( PxlColor shr 8 ) and $00FF ) + PxlColor and $0000FF ) div 3 + 100;
      //
      if c > 255 then
        c := 255;
      //
      Can.Pixels[x, y] := RGB( c, c, c );
    end;
end;

procedure RenderText(const aParent: TControl; const aCanvas: TCanvas;
  aText: string; const aFont: TFont; const aEnabled, aShowAccelChar: boolean;
  var Rect: TRect; Flags: integer);
  //
  procedure DoDrawText;
  begin
    DrawText( aCanvas.Handle, PChar( aText ), -1, Rect, Flags );
  end;
  //
begin
  if ( Flags and DT_CALCRECT <> 0 ) and ( ( aText = '' ) or aShowAccelChar
    and ( aText[1] = '&' ) and ( aText[2] = #0 ) ) then
    aText := aText + ' ';
  //
  if not( aShowAccelChar ) then
    Flags := Flags or DT_NOPREFIX;
  //
  Flags := aParent.DrawTextBiDiModeFlags( Flags );
  //
  aCanvas.Font.Assign( aFont );
  //
  if not( aEnabled ) then
    aCanvas.Font.Color := DXPColor_Msc_Dis_Caption_WXP;
  //
  if not( AEnabled ) then
  begin
    OffsetRect( Rect, 1, 1 );
    aCanvas.Font.Color := clBtnHighlight;
    DoDrawText;
    OffsetRect( Rect, -1, -1 );
    aCanvas.Font.Color := clBtnShadow;
    DoDrawText;
  end
  else
    DoDrawText;
end;

procedure Frame3d(const aCanvas: TCanvas; const Rect: TRect;
  const TopColor, BottomColor: TColor; const Swapped: boolean = false);
var
  aTopColor, aBottomColor: TColor;
begin
  aTopColor    := TopColor;
  aBottomColor := BottomColor;
  //
  if Swapped then
  begin
    aTopColor    := BottomColor;
    aBottomColor := TopColor;
  end;
  //
  aCanvas.Pen.Color := ATopColor;
  aCanvas.Polyline( [
    Point( Rect.Left, Rect.Bottom - 1 ),
    Point( Rect.Left, Rect.Top ),
    Point( Rect.Right - 1, Rect.Top )] );
  aCanvas.Pen.Color := ABottomColor;
  aCanvas.Polyline( [
    Point( Rect.Right - 1, Rect.Top + 1 ),
    Point( Rect.Right - 1 , Rect.Bottom - 1 ),
    Point( Rect.Left, Rect.Bottom - 1 )] );
end;

procedure ColorizeBitmap(aBitmap: TBitmap; const aColor: TColor);
var
  ColorMap: TBitmap;
  Rect: TRect;
begin
  Rect := Bounds( 0, 0, aBitmap.Width, aBitmap.Height );
  ColorMap := TBitmap.Create;
  //
  try
    ColorMap.Assign( aBitmap );
    aBitmap.Dormant;
    aBitmap.FreeImage;
    //
    ColorMap.Canvas.Brush.Color := AColor;
    ColorMap.Canvas.BrushCopy( Rect, aBitmap, Rect, clBlack );
    aBitmap.Assign( ColorMap );
    ColorMap.ReleaseHandle;
  finally
    ColorMap.Free;
  end;
end;

procedure SetDrawFlags(const aAlignment: TAlignment; const aWordWrap: boolean;
  var Flags: Integer);
begin
  Flags := DT_END_ELLIPSIS;
  //
  case aAlignment of
    taLeftJustify:
      Flags := Flags or DT_LEFT;
    taCenter:
      Flags := Flags or DT_CENTER;
    taRightJustify:
      Flags := Flags or DT_RIGHT;
  end;
  //
  if not( aWordWrap ) then
    Flags := Flags or DT_SINGLELINE
  else
    Flags := Flags or DT_WORDBREAK;
end;

procedure PlaceText(const aParent: TControl; const aCanvas: TCanvas;
  const aText: string; const aFont: TFont; const aEnabled, aShowAccelChar: boolean;
  const aAlignment: TAlignment; const aWordWrap: boolean; var Rect: TRect);
var
  Flags, dx, OH, OW: Integer;
begin
  OH := Rect.Bottom - Rect.Top;
  OW := Rect.Right - Rect.Left;
  SetDrawFlags( aAlignment, aWordWrap, Flags );
  //
  RenderText( aParent, aCanvas, aText, aFont, aEnabled, aShowAccelChar, Rect,
    Flags or DT_CALCRECT );
  //
  if aAlignment = taRightJustify then
    dx := OW - ( Rect.Right + Rect.Left )
  else if AAlignment = taCenter then
    dx := ( OW - Rect.Right ) div 2
  else
    dx := 0;
  //
  OffsetRect( Rect, dx, ( OH - Rect.Bottom ) div 2 );
  RenderText( aParent, aCanvas, aText, aFont, aEnabled, aShowAccelChar, Rect, Flags );
end;

end.
