unit DXPButtons;

interface

uses
  Windows, Classes, Graphics, Controls, Forms, ActnList, ImgList,
  DXPControl, DXPUtils, TypInfo, DXPCommonTypes, DXPConsts, DXPGradients,
  DXPColors, PngImage, SysUtils, Menus;

type
{ TDXPCustomButtonActionLink }
  TDXPCustomButtonActionLink = class(TWinControlActionLink)
  protected
    function IsImageIndexLinked: Boolean; override;
    procedure AssignClient(AClient: TObject); override;
    procedure SetImageIndex(Value: Integer); override;
    { Protected declarations }
  public
    destructor Destroy; override;
    { Public declarations }
  end;

{ TDXPCustomButton }
  TDXPLayout = (blGlyphLeft, blGlyphRight {, blGlyphTop, blGlyphBottom} );
  TDXPCustomButton = class(TDXPCustomStyleControl)
  private
    FAutoGray: Boolean;
    FBgGradient: TBitmap;
    FCancel: Boolean;
    FCkGradient: TBitmap;
    FDefault: Boolean;
    FFcGradient: TBitmap;
    FGlyph: TBitmap;
    FGlyphPng: TPngImage;
    FHlGradient: TBitmap;
    FImageChangeLink: TChangeLink;
    FImageIndex: Integer;
    FLayout: TDXPLayout;
    FShowAccelChar: Boolean;
    FShowFocusRect: Boolean;
    FSmoothEdges: Boolean;
    FSpacing: Byte;
    FWordWrap: Boolean;
    FColors: TDXPColors;
    FFlat: boolean;
    FFlatSet: boolean;
    FCaptionAlignment: TAlignment;
    FPopupMenu: TPopupMenu;
    FShowingPopup: boolean;
    //
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    //
    procedure ImageListChange(Sender: TObject);
    procedure SetFlat(const Value: boolean);
    procedure SetCaptionAlignment(const Value: TAlignment);
    procedure RecreateBmp;
    procedure RecreatePng;
    procedure RecreateBackGround;
    procedure SetPopupMenu(const Value: TPopupMenu);
    { Private declarations }
  protected
    function GetActionLinkClass: TControlActionLinkClass; override;
    function IsSpecialDrawState(IgnoreDefault: Boolean = False): Boolean;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure SetAutoGray(Value: Boolean); virtual;
    procedure SetDefault(Value: Boolean); virtual;
    procedure SetGlyph(Value: TBitmap); virtual;
    procedure SetGlyphPng(const Value: TPngImage); virtual;
    procedure SetLayout(Value: TDXPLayout); virtual;
    procedure SetShowAccelChar(Value: Boolean); virtual;
    procedure SetShowFocusRect(Value: Boolean); virtual;
    procedure SetSmoothEdges(Value: Boolean); virtual;
    procedure SetSpacing(Value: Byte); virtual;
    procedure SetWordWrap(Value: Boolean); virtual;
    procedure HookMouseEnter; override;
    procedure HookMouseLeave; override;
    procedure HookFocusedChanged; override;
    procedure Paint; override;
    procedure PaintPopUp; virtual;
    procedure ShowPopup;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    procedure Click; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Public declarations }
  published
    property Action;
    property AutoGray: Boolean read FAutoGray write SetAutoGray default True;
    property Caption;
    property CaptionAlignment: TAlignment read FCaptionAlignment write SetCaptionAlignment default taCenter;
    property Cancel: Boolean read FCancel write FCancel default False;
    property Colors: TDXPColors read FColors write FColors;
    property Default: Boolean read FDefault write SetDefault default False;
    property Enabled;
    property Flat: boolean read FFlat write SetFlat default false;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property GlyphPng: TPngImage read FGlyphPng write SetGlyphPng;
    property Height default 21;
    property Layout: TDXPLayout read FLayout write SetLayout default blGlyphLeft;
    property TabOrder;
    property TabStop default True;
    property ModalResult;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property ShowFocusRect: Boolean read FShowFocusRect write SetShowFocusRect default False;
    property SmoothEdges: Boolean read FSmoothEdges write SetSmoothEdges default True;
    property Spacing: Byte read FSpacing write SetSpacing default 3;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default True;
    property Width default 73;
    { Published declarations }
  end;

{ TDXPButton }
  TDXPButton = class(TDXPCustomButton);

{ TDXPToolType }
  TDXPToolType = (ttArrowLeft, ttArrowRight, ttClose, ttMaximize, ttMinimize,
                   ttPopup, ttRestore);

{ TDXPCustomToolButton }
  TDXPCustomToolButton = class(TDXPCustomStyleControl)
  private
    FToolType: TDXPToolType;
    { Private declarations }
  protected
    procedure SetToolType(Value: TDXPToolType); virtual;
    procedure Paint; override;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    procedure HookResized; override;
    { Public declarations }
  published
    property Enabled;
    property Color default clBlack;
    property Height default 15;
    property ToolType: TDXPToolType read FToolType write SetToolType default ttClose;
    property Width default 15;
    { Published declarations }
  end;

{ TDXPToolButton }
  TDXPToolButton = class(TDXPCustomToolButton);

implementation

{ TDXPCustomButtonActionLink }

procedure TDXPCustomButtonActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient( AClient );
  FClient := AClient as TDXPCustomButton;
end;

destructor TDXPCustomButtonActionLink.Destroy;
begin
  TDXPCustomButton( FClient ).Invalidate;
  inherited Destroy;
end;

function TDXPCustomButtonActionLink.IsImageIndexLinked: Boolean;
begin
  Result := true;
end;

procedure TDXPCustomButtonActionLink.SetImageIndex(Value: Integer);
begin
  inherited;
  ( FClient as TDXPCustomButton ).FImageIndex := Value;
  ( FClient as TDXPCustomButton ).Invalidate;
end;

{ TDXPCustomButton }

constructor TDXPCustomButton.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  //
  // set default properties.
  ControlStyle := ControlStyle - [csDoubleClicks];
  Height       := 21;
  Width        := 73;
  TabStop      := true;
  //
  // set custom properties.
  FAutoGray                 := true;
  FCancel                   := false;
  FCaptionAlignment         := taCenter;
  FDefault                  := false;
  FFlat                     := false;
  FFlatSet                  := FFlat;
  FImageIndex               := -1;
  FImageChangeLink          := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FLayout                   := blGlyphLeft;
  FShowAccelChar            := true;
  FShowFocusRect            := false;
  FSmoothEdges              := true;
  FSpacing                  := 3;
  FWordWrap                 := true;
  //
  RecreateBmp;
  RecreatePng;
  //
  // create ...
  FBgGradient := TBitmap.Create; // background gradient
  FCkGradient := TBitmap.Create; // clicked gradient
  FFcGradient := TBitmap.Create; // focused gradient
  FHlGradient := TBitmap.Create; // Highlight gradient
  FColors     := TDXPColors.Create( Self );
end;

destructor TDXPCustomButton.Destroy;
begin
  FColors.Free;
  FBgGradient.Free;
  FCkGradient.Free;
  FFcGradient.Free;
  FHlGradient.Free;
  FGlyphPng.Free;
  FGlyph.Free;
  FImageChangeLink.OnChange := nil;
  FImageChangeLink.Free;
  FImageChangeLink := nil;
  //
  inherited Destroy;
end;

function TDXPCustomButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TDXPCustomButtonActionLink;
end;

procedure TDXPCustomButton.Click;
begin
  inherited Click;
  //
  ShowPopup;
end;

procedure TDXPCustomButton.CMDialogKey(var Message: TCMDialogKey);
begin
  inherited;
  with Message do
    if ( ( ( CharCode = VK_RETURN ) and ( Focused or ( FDefault and not( IsSibling ) ) ) )
      or ( ( CharCode = VK_ESCAPE ) and FCancel ) and ( KeyDataToShiftState( KeyData ) = [] ) )
      and CanFocus then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TDXPCustomButton.SetAutoGray(Value: Boolean);
begin
  if Value <> FAutoGray then
  begin
    FAutoGray := Value;
    //
    if not( IsLocked ) then
      Invalidate;
  end;
end;

procedure TDXPCustomButton.SetCaptionAlignment(const Value: TAlignment);
begin
  if Value <> FCaptionAlignment then
  begin
    FCaptionAlignment := Value;
    Invalidate;
  end;
end;

procedure TDXPCustomButton.SetDefault(Value: Boolean);
begin
  if Value <> FDefault then
  begin
    FDefault := Value;
    //
    with GetParentForm( Self ) do
      Perform( CM_FOCUSCHANGED, 0, LongInt( ActiveControl ) );
  end;
end;

procedure TDXPCustomButton.SetFlat(const Value: boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    FFlatSet := FFlat;
    Invalidate;
  end;
end;

procedure TDXPCustomButton.SetGlyph(Value: TBitmap);
begin
  if Value <> FGlyph then
  begin
    FGlyph.Assign( Value );
    //
    if not( FGlyphPng.Empty ) then
      RecreatePng;
    //
    if not( IsLocked ) then
      Invalidate;
  end;
end;

procedure TDXPCustomButton.SetGlyphPng(const Value: TPngImage);
begin
  // This is all neccesary, because you can't assign a nil to a TPngImage
  if Value = nil then
  begin
    FGlyphPng.Free;
    FGlyphPng := TPngImage.Create;
  end
  else
    FGlyphPng.Assign( Value );
  //
  if not( FGlyph.Empty ) then
    RecreateBmp;
  //
  // To work around the gamma-problem
  with FGlyphPng do
    if not Empty and ( Header.ColorType in [COLOR_RGB, COLOR_RGBALPHA, COLOR_PALETTE] ) then
      Chunks.RemoveChunk( Chunks.ItemFromClass( TChunkgAMA ) );
  //
  if not( IsLocked ) then
    Invalidate;
end;

procedure TDXPCustomButton.SetLayout(Value: TDXPLayout);
begin
  if Value <> FLayout then
  begin
    FLayout := Value;
    //
    if not( IsLocked ) then
      Invalidate;
  end;
end;

procedure TDXPCustomButton.SetPopupMenu(const Value: TPopupMenu);
begin
  if Assigned( FPopupMenu ) then
    FPopupMenu.RemoveFreeNotification( Self );
  //
  if Value <> FPopupMenu then
  begin
    FPopupMenu := Value;
    Invalidate;
  end;
  //
  if Assigned( FPopupMenu ) then
    FPopupMenu.FreeNotification( Self );
end;

procedure TDXPCustomButton.SetShowAccelChar(Value: Boolean);
begin
  if Value <> FShowAccelChar then
  begin
    FShowAccelChar := Value;
    //
    if not( IsLocked ) then
      Invalidate;
  end;
end;

procedure TDXPCustomButton.SetShowFocusRect(Value: Boolean);
begin
  if Value <> FShowFocusRect then
  begin
    FShowFocusRect := Value;
    //
    if not( IsLocked ) then
      Invalidate;
  end;
end;

procedure TDXPCustomButton.SetSmoothEdges(Value: Boolean);
begin
  if Value <> FSmoothEdges then
  begin
    FSmoothEdges := Value;
    //
    if not( IsLocked ) then
      Invalidate;
  end;
end;

procedure TDXPCustomButton.SetSpacing(Value: Byte);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    //
    if not( IsLocked ) then
      Invalidate;
  end;
end;

procedure TDXPCustomButton.SetWordWrap(Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    //
    if not( IsLocked ) then
      Invalidate;
  end;
end;

procedure TDXPCustomButton.ShowPopup;
begin
  if Assigned( PopupMenu ) then
  begin
    FShowingPopup := True;
    //
    PopupMenu.Popup( ClientOrigin.X + ClientRect.Right,
      ClientOrigin.Y );
    //
    FShowingPopup := False;
    FFlat := FFlatSet;
  end;
end;

procedure TDXPCustomButton.ImageListChange(Sender: TObject);
begin
  if Assigned( Action ) and ( Sender is TCustomImageList )
    and Assigned( TAction( Action ).ActionList.Images )
    and ( ( TAction( Action ).ImageIndex < ( TAction( Action ).ActionList.Images.Count ) ) ) then
    FImageIndex := TAction( Action ).ImageIndex
  else
    FImageIndex := -1;
  if not( IsLocked ) then
    Invalidate;
end;

procedure TDXPCustomButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if ( Shift = [] ) and ( Key = VK_SPACE ) then
  begin
    DrawState := DrawState + [dsHighlight];
    HookMouseDown;
  end;
  //
  inherited;
end;

procedure TDXPCustomButton.KeyUp(var Key: Word; Shift: TShiftState);
var
  cPos: TPoint;
begin
  //
  // it's not possible to call the 'HookMouseUp' or 'HookMouseLeave' methods,
  // because we don't want to call there event handlers.
  //
  if dsClicked in DrawState then
  begin
    GetCursorPos( cPos );
    cPos := ScreenToClient( cPos );
    //
    if not PtInRect( Bounds( 0, 0, Width, Height ), cPos ) then
      DrawState := DrawState - [dsHighlight];
    //
    DrawState := DrawState - [dsClicked];
    //
    if not( IsLocked ) then
      Invalidate;
    //
    Click;
  end;
  //
  inherited;
end;

procedure TDXPCustomButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification( AComponent, Operation );
  //
  if ( AComponent = FPopupMenu ) and ( Operation = opRemove ) then
    FPopupMenu := nil;
end;

function TDXPCustomButton.IsSpecialDrawState(IgnoreDefault: Boolean = False): Boolean;
begin
  if dsClicked in DrawState then
    Result := not( dsHighlight in DrawState )
  else
    Result := ( dsHighlight in DrawState ) or ( dsFocused in DrawState );
  //
  if not( IgnoreDefault ) then
    Result := Result or ( FDefault and CanFocus ) and not( IsSibling );
end;

procedure TDXPCustomButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange( Sender, CheckDefaults );
  //
  if Sender is TCustomAction then
    with TCustomAction( Sender ) do
    begin
      if Assigned( TCustomAction( Sender ).ActionList.Images ) and
        ( FImageChangeLink.Sender <> TCustomAction( Sender ).ActionList.Images ) then
        TCustomAction( Sender ).ActionList.Images.RegisterChanges( FImageChangeLink );
      //
      if ( ActionList <> nil ) and ( ActionList.Images <> nil ) and
        ( ImageIndex >= 0 ) and ( ImageIndex < ActionList.Images.Count ) then
        FImageIndex := ImageIndex;
      //
      if not( IsLocked ) then
        Invalidate;
    end;
end;

procedure TDXPCustomButton.HookFocusedChanged;
begin
  if ( FFlat ) and ( Focused ) then
    FFlat := false
  else if not( Focused ) then
    FFlat := FFlatSet;
  //
  inherited HookFocusedChanged;
end;

procedure TDXPCustomButton.HookMouseEnter;
begin
  if FFlat then
    FFlat := false;
  //
  inherited HookMouseEnter;
end;

procedure TDXPCustomButton.HookMouseLeave;
begin
  if not FShowingPopup then
    FFlat := FFlatSet;
  inherited HookMouseLeave;
end;

procedure TDXPCustomButton.Paint;
const
  SPACEBORDER: integer = 5;
//
var
  RectCaption,
  RectImage: TRect;
  Offset, Flags: Integer;
  DrawPressed: Boolean;
  Image: TGraphic;
  BorderBmp: TBitmap;
  CaptionVerticalCenter: integer;
//
  procedure DrawGlyphBitmap(aCanvas: TCanvas; aOffSet: integer);
  begin
    if Image.Empty then
      Exit
    else
      Image.Transparent := true;
    //
    if Caption = '' then
      aCanvas.Draw( ( ( Width - Image.Width ) div 2 ) - aOffSet, ( ( Height - Image.Height ) div 2 + Integer( DrawPressed ) ) - aOffSet, Image )
    else
      case FLayout of
        blGlyphLeft:
          aCanvas.Draw( ( RectImage.Left + SPACEBORDER ) - aOffSet, ( ( Height - Image.Height ) div 2 + Integer( DrawPressed ) ) - aOffSet, Image );
        blGlyphRight:
          aCanvas.Draw( ( RectImage.Right - ( Image.Width + SPACEBORDER ) ) - aOffSet, ( ( Height - Image.Height ) div 2 + Integer( DrawPressed ) ) - aOffSet, Image );
      end;
  end;
//
begin
  BorderBmp := nil;
  //
  if not( FFlat ) then
    RecreateBackGround;
  //
  with Canvas do
  begin
    // RectImage
    RectImage.Left   := 0;
    RectImage.Top    := 0;
    RectImage.Bottom := Height;
    RectImage.Right  := Width;
    //
    // clear background.
    RectCaption := GetClientRect;
    Brush.Color := Color;
    FillRect( RectCaption );
    //
    // draw image
    DrawPressed := ( dsHighlight in DrawState ) and ( dsClicked in DrawState );
    //
    if DrawPressed then
      OffsetRect( RectCaption, 1, 1 );
    //
    if not( FGlyph.Empty ) then
    begin
      Image := TBitmap.Create;
      Image.Assign( FGlyph );
    end
    else
    begin
      Image := TPngImage.Create;
      Image.Assign( FGlyphPng );
    end;
    //
    if not( FFlat ) then
    begin
      // draw gradient borders.
      if IsSpecialDrawState then
      begin
        BorderBmp := TBitmap.Create;
        //
        if dsHighlight in DrawState then
          BorderBmp.Assign( FHlGradient )
        else
          BorderBmp.Assign( FFcGradient );
      end;
      //
      // draw background gradient...
      if not( ( dsHighlight in DrawState ) and ( dsClicked in DrawState ) ) then
      begin
        Offset := 2 * Integer( IsSpecialDrawState );
        //
        if Assigned( BorderBmp ) then
        begin
          DrawGlyphBitmap( FBgGradient.Canvas, Offset + 1 );
          BitBlt( Handle, 1, 1, Width, Height, BorderBmp.Canvas.Handle, 0, 0, SRCCOPY );
          BitBlt( Handle, 3, 3, Width, Height, FBgGradient.Canvas.Handle, 0, 0, SRCCOPY );
        end
        else
        begin
          DrawGlyphBitmap( FBgGradient.Canvas, 0 );
          BitBlt( Handle, 0, 0, Width, Height, FBgGradient.Canvas.Handle, 0, 0, SRCCOPY );
        end;
      end
      //
      // ...or click gradient.
      else
      begin
        DrawGlyphBitmap( FCkGradient.Canvas, 0 );
        BitBlt( Handle, 1, 1, Width, Height, FCkGradient.Canvas.Handle, 0, 0, SRCCOPY );
      end;
      //
      // draw border lines.
      if Enabled then
        Pen.Color := FColors.BorderLine
      else
        Pen.Color := FColors.BorderLineDisabled;
      //
      Brush.Style := bsClear;
      RoundRect( 0, 0, Width, Height, 5, 5 );
      //
      // draw border edges.
      if FSmoothEdges then
      begin
        if Enabled then
          Pen.Color := FColors.BorderLine
        else
          Pen.Color := FColors.BorderLineDisabled;
        //
        DrawLine( Canvas, 0, 1, 2, 0 );
        DrawLine( Canvas, Width - 2, 0, Width, 2 );
        DrawLine( Canvas, 0, Height - 2, 2, Height );
        DrawLine( Canvas, Width - 3, Height, Width, Height - 3 );
      end;
    end
    // ... else Flat
    else
      DrawGlyphBitmap( Canvas, 0 );
    //
    // set drawing flags.
    Flags := DT_END_ELLIPSIS;
    //
    if FWordWrap then
      Flags := Flags or DT_WORDBREAK;
    //
    // draw caption.
    try
      // get image from action or glyph property.
      {
      if Assigned( Action ) and Assigned( TAction( Action ).ActionList.Images ) and
        ( FImageIndex > -1 ) and ( FImageIndex < TAction( Action ).ActionList.Images.Count ) then
        TAction( Action ).ActionList.Images.GetBitmap( FImageIndex, Image )
      else
        Image.Assign( FGlyph );
      }
      //
      // assign canvas font (change HotTrack-Color, if necessary).
      Font.Assign( Self.Font );
      //
      RenderText( Self, Canvas, Caption, Font, Enabled, FShowAccelChar, RectCaption, Flags or DT_CALCRECT );
      CaptionVerticalCenter := ( Height - RectCaption.Bottom ) div 2;
      //
      // calculate textrect.
      case FCaptionAlignment of
        taLeftJustify:
        begin
          if FLayout = blGlyphLeft then
            OffsetRect( RectCaption, SPACEBORDER + Image.Width + FSpacing, CaptionVerticalCenter )
          else
            OffsetRect( RectCaption, SPACEBORDER, CaptionVerticalCenter )
        end;
        //
        taRightJustify:
        begin
          if FLayout = blGlyphRight then
            OffsetRect( RectCaption, Width - ( Canvas.TextWidth( Caption ) + SPACEBORDER + Image.Width + FSpacing ), CaptionVerticalCenter )
          else
            OffsetRect( RectCaption, Width - ( Canvas.TextWidth( Caption ) + SPACEBORDER ), CaptionVerticalCenter );
        end;
        //
        taCenter: OffsetRect( RectCaption, ( Width - RectCaption.Right ) div 2, CaptionVerticalCenter );
      end;
      //
      // draw focusrect (if enabled).'
      if ( dsFocused in DrawState ) and ( FShowFocusRect ) then
      begin
        Brush.Style := bsSolid;
        DrawFocusRect( Bounds( 3, 3, Width - 6, Height - 6 ) );
      end;
      //
      // draw caption.
      SetBkMode( Handle, Transparent );
      RenderText( Self, Canvas, Caption, Font, Enabled, FShowAccelChar, RectCaption, Flags );
      //
      // Paint seta do menu
      PaintPopUp;
    finally
      if Assigned( BorderBmp ) then
        FreeAndNil( BorderBmp );
      //
      FreeAndNil( Image );
    end;
  end;
end;

procedure TDXPCustomButton.PaintPopUp;
var
  aRight,
  aTop: integer;
begin
  if not( Assigned( FPopupMenu ) ) then
    Exit;
  //
  aRight := Width - 15;
  aTop   := ( Height div 2 ) - 5;
  //
  Canvas.Brush.Color := clBlack;
  Canvas.Pen.Color   := clBlack;
  Canvas.Polygon( [Point( aRight, aTop ),
                   Point( aRight + 5, aTop + 5 ),
                   Point( aRight, aTop + 10 )] );
end;

procedure TDXPCustomButton.RecreateBackGround;
const
  ColSteps = 64;
  Dithering = True;
var
  Offset: Integer;
begin
  // calculate offset.
  Offset := 4 * ( integer( IsSpecialDrawState( true ) ) );
  //
  // create gradient rectangles for...
  //
  // background.
  CreateGradientRect( Width - ( 2 + Offset ), Height - ( 2 + Offset ),
    FColors.BackGroundFrom, FColors.BackGroundTo, ColSteps, gsTop, Dithering,
    FBgGradient );
  //
  // clicked.
  CreateGradientRect( Width - 2, Height - 2, FColors.ClickedFrom,
    FColors.ClickedTo, ColSteps, gsTop, Dithering, FCkGradient );
  //
  // focused.
  CreateGradientRect( Width - 2, Height - 2, FColors.FocusedFrom,
    FColors.FocusedTo, ColSteps, gsTop, Dithering, FFcGradient );
  //
  // highlight.
  CreateGradientRect( Width - 2, Height - 2, FColors.HighlightFrom,
    FColors.HighlightTo, ColSteps, gsTop, Dithering, FHlGradient );
end;

procedure TDXPCustomButton.RecreateBmp;
begin
  FreeAndNil( FGlyph );
  FGlyph := TBitmap.Create;
end;

procedure TDXPCustomButton.RecreatePng;
begin
  FreeAndNil( FGlyphPng );
  FGlyphPng := TPngImage.Create;
end;

{ TDXPCustomToolButton }

constructor TDXPCustomToolButton.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  ControlStyle := ControlStyle - [csDoubleClicks];
  Color        := clBlack;
  FToolType    := ttClose;
  HookResized;
end;

procedure TDXPCustomToolButton.HookResized;
begin
  Height := 15;
  Width  := 15;
end;

procedure TDXPCustomToolButton.SetToolType(Value: TDXPToolType);
begin
  if Value <> FToolType then
  begin
    FToolType := Value;
    //
    if not( IsLocked ) then
      Invalidate;
  end;
end;

procedure TDXPCustomToolButton.Paint;
var
  Rect: TRect;
  Bitmap: TBitmap;
  Theme: TDXPTheme;
  Shifted: Boolean;
begin
  with Canvas do
  begin
    Rect := GetClientRect;
    Brush.Color := TDXPWinControl( Parent ).Color;
    FillRect( Rect );
    //
    if csDesigning in ComponentState then
      DrawFocusRect( Rect );
    //
    Brush.Style := bsClear;
    Theme       := Style.GetTheme;
    //
    if ( Theme = WindowsXP ) and ( dsClicked in DrawState ) and
      not( dsHighlight in DrawState ) then
      Frame3d( Self.Canvas, Rect, clWhite, clBlack );
    //
    if dsHighlight in DrawState then
    begin
      if Theme = WindowsXP then
        Frame3d( Self.Canvas, Rect, clWhite, clBlack, dsClicked in DrawState )
      else
      begin
        Pen.Color := DXPColor_BorderLineOXP;
        Rectangle( Rect );
        InflateRect( Rect, -1, -1 );
        //
        if dsClicked in DrawState then
          Brush.Color := DXPColor_BgCkOXP
        else
          Brush.Color := DXPColor_BgOXP;
        //
        FillRect( Rect );
      end;
    end;
    //
    Shifted := ( Theme = WindowsXP ) and ( dsClicked in DrawState );
    Bitmap := TBitmap.Create;
    try
      Bitmap.Handle := LoadBitmap( hInstance, PChar( Copy( GetEnumName( TypeInfo( TDXPToolType ),
        Ord( FToolType ) ), 3, MAXINT ) ) );
      //
      if ( dsClicked in DrawState ) and ( dsHighlight in DrawState ) then
        ColorizeBitmap( Bitmap, clWhite )
      else
      if not( Enabled ) then
        ColorizeBitmap( Bitmap, clGray )
      else
      if Color <> clBlack then
        ColorizeBitmap( Bitmap, Color );
      //
      Bitmap.Transparent := true;
      Draw( ( Width - Bitmap.Width ) div 2 + Integer( Shifted ),
        ( Height - Bitmap.Height ) div 2 + Integer( Shifted ), Bitmap );
    finally
      Bitmap.Free;
    end;
  end;
end;

end.

