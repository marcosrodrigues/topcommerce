unit DXPPanelDegrade;

interface

uses
  Windows, Graphics, Messages, SysUtils, Classes, Controls, ExtCtrls, Types,
  Forms, DXPUtils, DXPGradients;

type
  TDXPDegradeDirection=(ddVertical, ddHorizontal);
  //
  TDXPPanelDegrade = class(TCustomPanel)
  private
    FInvert: boolean;
    FDirection: TDXPDegradeDirection;
    FBgGradient: TBitmap;
    FBackGround: TColor;
    FBorderLineColor: TColor;
    //
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    //
    procedure SetBackGround(const Value: TColor);
    procedure SetDirection(const Value: TDXPDegradeDirection);
    procedure SetInvert(const Value: boolean);
    procedure SetBorderLineColor(const Value: TColor);
    { Private declarations }
  protected
    procedure HookRedraw; dynamic;
    { Protected declarations }
  public
    constructor Create(aOwner:tcomponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Invalidate; override;
    { Public declarations }
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BackGround: TColor read FBackGround write SetBackGround default clGray;
    property BorderLineColor: TColor read FBorderLineColor write SetBorderLineColor default clGray;
    {
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    }
    property BiDiMode;
    property Caption;
    property Color default clWindow;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property Direction: TDXPDegradeDirection read FDirection write SetDirection default ddVertical;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Invert: boolean read FInvert write SetInvert default false;
    property Locked;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
    { Published declarations }
  end;

implementation

{ TDXPPanelDegrade }

constructor TDXPPanelDegrade.Create(aOwner: tcomponent);
begin
  inherited Create( aOwner );
  //
  Align       := alNone;
  Color       := clWindow;
  Caption     := '';
  FInvert     := false;
  FDirection  := ddVertical;
  FBackGround := clGray;
  FBorderLineColor := clGray;
  //
  FBgGradient := TBitmap.Create;
end;

destructor TDXPPanelDegrade.Destroy;
begin
  FreeAndNil( FBgGradient );
  inherited Destroy;
end;

procedure TDXPPanelDegrade.HookRedraw;
const
  ColSteps = 64;
  Dithering = True;
begin
  if not( Assigned( FBgGradient ) ) then
    Exit;
  //
  inherited;
  //
  // create gradient rectangles for...
  // background.
  CreateGradientRect( Width, Height, FBackGround, Color,
    ColSteps, gsTop, Dithering, FBgGradient );
end;

procedure TDXPPanelDegrade.Invalidate;
begin
  HookRedraw;
  inherited Invalidate;
end;

procedure TDXPPanelDegrade.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
  VerticalAlignments: array[TVerticalAlignment] of Longint = (DT_TOP, DT_BOTTOM, DT_VCENTER);
var
  Rect: TRect;
  Flags: Integer;
begin
  with Canvas do
  begin
    // clear background.
    Rect        := GetClientRect;
    Brush.Color := Color;
    FillRect( Rect );
    //
    // draw background gradient...
    BitBlt( Handle, 1, 1, Width, Height, FBgGradient.Canvas.Handle, 0, 0, SRCCOPY );
    //
    Pen.Color := FBorderLineColor;
    Brush.Style := bsClear;
    RoundRect( 0, 0, Width, Height, 5, 5 );
    //
    // Border line top
    Pen.Color := FBackGround;
    DrawLine( Canvas, 0, 1, 2, 0 );
    DrawLine( Canvas, Width - 2, 0, Width, 2 );
    DrawLine( Canvas, 0, Height - 2, 2, Height );
    DrawLine( Canvas, Width - 3, Height, Width, Height - 3 );
    //
    // draw caption.
    if ( ShowCaption ) and ( Caption <> '' ) then
    begin
      Brush.Style := bsClear;
      Font := Self.Font;
      Flags := DT_EXPANDTABS or DT_SINGLELINE or
        VerticalAlignments[VerticalAlignment] or Alignments[Alignment];
      Flags := DrawTextBiDiModeFlags(Flags);
      DrawText(Handle, Caption, -1, Rect, Flags);
    end;
  end;
end;

procedure TDXPPanelDegrade.SetBackGround(const Value: TColor);
begin
  FBackGround := Value;
  Invalidate;
end;

procedure TDXPPanelDegrade.SetBorderLineColor(const Value: TColor);
begin
  FBorderLineColor := Value;
  Invalidate;
end;

procedure TDXPPanelDegrade.SetDirection(const Value: TDXPDegradeDirection);
begin
  FDirection := Value;
  Invalidate;
end;

procedure TDXPPanelDegrade.SetInvert(const Value: boolean);
begin
  FInvert := Value;
  Invalidate;
end;

procedure TDXPPanelDegrade.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

end.
