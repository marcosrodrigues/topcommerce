unit DXPGradients;

interface

uses
  Windows, Graphics, Classes, DXPControl, Controls, Types;

type
  TDXPGradientColors = 2..255;
  TDXPGradientStyle = (gsLeft, gsTop, gsRight, gsBottom);

  TDXPGradient = class(TPersistent)
  private
    FColors: TDXPGradientColors;
    FDithered: Boolean;
    FEnabled: Boolean;
    FEndColor: TColor;
    FStartColor: TColor;
    FGradientStyle: TDXPGradientStyle;
    FBitmap: TBitmap;
    { Private declarations }
  protected
    Parent: TDXPCustomControl;
    procedure SetDithered(Value: Boolean); virtual;
    procedure SetColors(Value: TDXPGradientColors); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetEndColor(Value: TColor); virtual;
    procedure SetGradientStyle(Value: TDXPGradientStyle); virtual;
    procedure SetStartColor(Value: TColor); virtual;
    { Protected declarations }
  public
    property Bitmap: TBitmap read FBitmap;
    //
    constructor Create(AOwner: TControl);
    destructor Destroy; override;
    procedure RecreateBands; virtual;
    { Public declarations }
  published
    property Dithered: Boolean read FDithered write SetDithered default True;
    property Colors: TDXPGradientColors read FColors write SetColors default 16;
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property EndColor: TColor read FEndColor write SetEndColor default clSilver;
    property StartColor: TColor read FStartColor write SetStartColor default clGray;
    property Style: TDXPGradientStyle read FGradientStyle write SetGradientStyle default gsLeft;
    { Published declarations }
  end;
//
procedure CreateGradientRect(const aWidth, aHeight: integer; const StartColor,
  EndColor: TColor; const Colors: TDXPGradientColors; const Style: TDXPGradientStyle;
  const aDithered: Boolean; var aBitmap: TBitmap);

implementation

{ TDXPGradient }

constructor TDXPGradient.Create(AOwner: TControl);
begin
  inherited Create;
  Parent         := TDXPCustomControl( AOwner );
  FBitmap        := TBitmap.Create;
  FColors        := 16;
  FDithered      := true;
  FEnabled       := false;
  FEndColor      := clSilver;
  FGradientStyle := gsLeft;
  FStartColor    := clGray;
end;

destructor TDXPGradient.Destroy;
begin
  FBitmap.Free;
  inherited Destroy;
end;

procedure TDXPGradient.RecreateBands;
begin
  if Assigned( FBitmap ) then
    CreateGradientRect( Parent.Width, Parent.Height, FStartColor, FEndColor,
      FColors, FGradientStyle, FDithered, FBitmap );
end;

procedure TDXPGradient.SetColors(Value: TDXPGradientColors);
begin
  if FColors <> Value then
  begin
    FColors := Value;
    RecreateBands;
    Parent.Redraw;
  end;
end;

procedure TDXPGradient.SetDithered(Value: Boolean);
begin
  if FDithered <> Value then
  begin
    FDithered := Value;
    RecreateBands;
    Parent.Redraw;
  end;
end;

procedure TDXPGradient.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Parent.Redraw;
  end;
end;

procedure TDXPGradient.SetEndColor(Value: TColor);
begin
  if FEndColor <> Value then
  begin
    FEndColor := Value;
    RecreateBands;
    Parent.Redraw;
  end;
end;

procedure TDXPGradient.SetGradientStyle(Value: TDXPGradientStyle);
begin
  if FGradientStyle <> Value then
  begin
    FGradientStyle := Value;
    RecreateBands;
    Parent.Redraw;
  end;
end;

procedure TDXPGradient.SetStartColor(Value: TColor);
begin
  if FStartColor <> Value then
  begin
    FStartColor := Value;
    RecreateBands;
    Parent.Redraw;
  end;
end;

{ Static Methods }

procedure CreateGradientRect(const aWidth, aHeight: integer; const StartColor,
  EndColor: TColor; const Colors: TDXPGradientColors; const Style: TDXPGradientStyle;
  const aDithered: Boolean; var aBitmap: TBitmap);
//
const
  PixelCountMax = 32768;
//
type
  TGradientBand = array[0..255] of TColor;
  TRGBMap = packed record
    case boolean of
      true: ( RGBVal: DWord );
      false: ( R, G, B, D: Byte );
  end;
  //
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..PixelCountMax-1] of TRGBTriple;
//
const
  DitherDepth = 16;
var
  iLoop, xLoop, yLoop, XX, YY: Integer;
  iBndS, iBndE: Integer;
  GBand: TGradientBand;
  Row:  pRGBTripleArray;
  //
  procedure CalculateGradientBand;
  var
    rR, rG, rB: Real;
    lCol, hCol: TRGBMap;
    iStp: Integer;
  begin
    if Style in [gsLeft, gsTop] then
    begin
      lCol.RGBVal := ColorToRGB( StartColor );
      hCol.RGBVal := ColorToRGB( EndColor );
    end
    else
    begin
      lCol.RGBVal := ColorToRGB( EndColor );
      hCol.RGBVal := ColorToRGB( StartColor );
    end;
    //
    rR := ( hCol.R - lCol.R ) / ( Colors - 1 );
    rG := ( hCol.G - lCol.G ) / ( Colors - 1 );
    rB := ( hCol.B - lCol.B ) / ( Colors - 1 );
    //
    for iStp := 0 to ( Colors - 1 ) do
      GBand[iStp] := RGB(
        lCol.R + Round( rR * iStp ),
        lCol.G + Round( rG * iStp ),
        lCol.B + Round( rB * iStp )
        );
  end;
//
begin
  aBitmap.Height := AHeight;
  aBitmap.Width  := AWidth;
  //
  if aBitmap.PixelFormat <> pf24bit then
    aBitmap.PixelFormat := pf24bit;
  //
  CalculateGradientBand;
  //
  aBitmap.Canvas.Brush.Color := StartColor;
  aBitmap.Canvas.FillRect( Bounds( 0, 0, aWidth, aHeight ) );
  //
  if Style in [gsLeft, gsRight] then
  begin
    for iLoop := 0 to Colors - 1 do
    begin
      iBndS := MulDiv( iLoop, aWidth, Colors );
      iBndE := MulDiv( iLoop + 1, aWidth, Colors );
      aBitmap.Canvas.Brush.Color := GBand[iLoop];
      PatBlt( aBitmap.Canvas.Handle, iBndS, 0, iBndE, AHeight, PATCOPY );
      //
      if ( iLoop > 0 ) and ( aDithered ) then
        for yLoop := 0 to DitherDepth - 1 do
          if ( yLoop < aHeight ) then
          begin
            Row := aBitmap.Scanline[yLoop];
            //
            for xLoop := 0 to aWidth div ( Colors - 1 ) do
            begin
              XX := iBndS + Random( xLoop );
              //
              if ( XX < aWidth ) and ( XX > -1 ) then
                with Row[XX] do
                begin
                  rgbtRed   := GetRValue( GBand[iLoop - 1] );
                  rgbtGreen := GetGValue( GBand[iLoop - 1] );
                  rgbtBlue  := GetBValue( GBand[iLoop - 1] );
                end;
            end;
          end;
    end;
    //
    for yLoop := 1 to aHeight div DitherDepth do
      aBitmap.Canvas.CopyRect( Bounds( 0, yLoop * DitherDepth, aWidth, DitherDepth ),
                               aBitmap.Canvas, Bounds( 0, 0, aWidth, DitherDepth ) );
  end
  else
  begin
    for iLoop := 0 to Colors - 1 do
    begin
      iBndS := MulDiv( iLoop, aHeight, Colors );
      iBndE := MulDiv( iLoop + 1, aHeight, Colors );
      aBitmap.Canvas.Brush.Color := GBand[iLoop];
      PatBlt( aBitmap.Canvas.Handle, 0, iBndS, aWidth, iBndE, PATCOPY );
      //
      if ( iLoop > 0 ) and ( aDithered ) then
        for yLoop := 0 to aHeight div ( Colors - 1 ) do
        begin
          YY := iBndS + Random( yLoop );
          //
          if ( YY < aHeight ) and ( YY > -1 ) then
          begin
            Row := aBitmap.Scanline[YY];
            //
            for xLoop := 0 to DitherDepth - 1 do
              if ( xLoop < aWidth ) then
                with Row[xLoop] do
                begin
                  rgbtRed   := GetRValue( GBand[iLoop - 1] );
                  rgbtGreen := GetGValue( GBand[iLoop - 1] );
                  rgbtBlue  := GetBValue( GBand[iLoop - 1] );
                end;
          end;
        end;
    end;
    //
    for xLoop := 0 to aWidth div DitherDepth do
      aBitmap.Canvas.CopyRect( Bounds( xLoop * DitherDepth, 0, DitherDepth, aHeight ),
                               aBitmap.Canvas, Bounds(0, 0, DitherDepth, aHeight ) );
  end;
end;

end.
