unit DXPColors;

interface

uses
  Classes, Graphics, DXPConsts, DXPControl;

type
  TDXPColors = class(TPersistent)
  private
    { Private declarations }
    FBackGroundFrom: TColor;
    FBackGroundTo: TColor;
    FBorderEdges: TColor;
    FBorderLine: TColor;
    FClickedFrom: TColor;
    FClickedTo: TColor;
    FFocusedFrom: TColor;
    FFocusedTo: TColor;
    FHighlightFrom: TColor;
    FHighlightTo: TColor;
    FHotTrack: TColor;
    FBorderLineDisabled: TColor;
    FBorderEdgesDisabled: TColor;
    procedure SetBorderLineDisabled(const Value: TColor);
  protected
    { Protected declarations }
    FOwner: TObject;
    procedure RepaintOwner;
    procedure SetBackGroundFrom(Value: TColor); virtual;
    procedure SetBackGroundTo(Value: TColor); virtual;
    procedure SetBorderEdges(Value: TColor); virtual;
    procedure SetBorderLine(Value: TColor); virtual;
    procedure SetClickedFrom(Value: TColor); virtual;
    procedure SetClickedTo(Value: TColor); virtual;
    procedure SetFocusedFrom(Value: TColor); virtual;
    procedure SetFocusedTo(Value: TColor); virtual;
    procedure SetHighlightFrom(Value: TColor); virtual;
    procedure SetHighlightTo(Value: TColor); virtual;
    procedure SetHotTrack(Value: TColor); virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent);
  published
    { Published declarations }
    property BackGroundFrom: TColor read FBackGroundFrom write SetBackGroundFrom default DXPColor_Enb_BgFrom_WXP;
    property BackGroundTo: TColor read FBackGroundTo write SetBackGroundTo default DXPColor_Enb_BgTo_WXP;
    //property BorderEdges: TColor read FBorderEdges write SetBorderEdges default DXPColor_Enb_Edges_WXP;
    //property BorderEdgesDisabled: TColor read FBorderEdgesDisabled write SetBorderEdgesDisabled default DXPColor_Dis_Edges_WXP;
    property BorderLine: TColor read FBorderLine write SetBorderLine default DXPColor_Enb_Border_WXP;
    property BorderLineDisabled: TColor read FBorderLineDisabled write SetBorderLineDisabled default DXPColor_Dis_Border_WXP;
    property ClickedFrom: TColor read FClickedFrom write SetClickedFrom default DXPColor_Enb_CkFrom_WXP;
    property ClickedTo: TColor read FClickedTo write SetClickedTo default DXPColor_Enb_CkTo_WXP;
    property FocusedFrom: TColor read FFocusedFrom write SetFocusedFrom default DXPColor_Enb_FcFrom_WXP;
    property FocusedTo: TColor read FFocusedTo write SetFocusedTo default DXPColor_Enb_FcTo_WXP;
    property HighlightFrom: TColor read FHighlightFrom write SetHighlightFrom default DXPColor_Enb_HlFrom_WXP;
    property HighlightTo: TColor read FHighlightTo write SetHighlightTo default DXPColor_Enb_HlTo_WXP;
    //property HotTrack: TColor read FHotTrack write SetHotTrack default DXPColor_Enb_HotTrack_WXP;
  end;

implementation

{ TDXPColors }

constructor TDXPColors.Create(AOwner: TComponent);
begin
  inherited Create;
  //
  FOwner               := AOwner;
  FBackGroundFrom      := DXPColor_Enb_BgFrom_WXP;
  FBackGroundTo        := DXPColor_Enb_BgTo_WXP;
  FBorderEdges         := DXPColor_Enb_Edges_WXP;
  FBorderEdgesDisabled := DXPColor_Dis_Edges_WXP;
  FBorderLine          := DXPColor_Enb_Border_WXP;
  FBorderLineDisabled  := DXPColor_Dis_Border_WXP;
  FClickedFrom         := DXPColor_Enb_CkFrom_WXP;
  FClickedTo           := DXPColor_Enb_CkTo_WXP;
  FFocusedFrom         := DXPColor_Enb_FcFrom_WXP;
  FFocusedTo           := DXPColor_Enb_FcTo_WXP;
  FHighlightFrom       := DXPColor_Enb_HlFrom_WXP;
  FHighlightTo         := DXPColor_Enb_HlTo_WXP;
  FHotTrack            := DXPColor_Enb_HotTrack_WXP;
end;

procedure TDXPColors.RepaintOwner;
begin
  if FOwner is TDXPCustomControl then
    ( FOwner as TDXPCustomControl ).Redraw;
end;

procedure TDXPColors.SetBackGroundFrom(Value: TColor);
begin
  if FBackGroundFrom <> Value then
    FBackGroundFrom := Value;
  //
  RepaintOwner;
end;

procedure TDXPColors.SetBackGroundTo(Value: TColor);
begin
  if FBackGroundTo <> Value then
    FBackGroundTo := Value;
end;

procedure TDXPColors.SetBorderEdges(Value: TColor);
begin
  if FBorderEdges <> Value then
    FBorderEdges := Value;
end;

procedure TDXPColors.SetBorderLine(Value: TColor);
begin
  if FBorderLine <> Value then
    FBorderLine := Value;
end;

procedure TDXPColors.SetBorderLineDisabled(const Value: TColor);
begin
  if FBorderLineDisabled <> Value then
    FBorderLineDisabled := Value;
end;

procedure TDXPColors.SetClickedFrom(Value: TColor);
begin
  if FClickedFrom <> Value then
    FClickedFrom := Value;
end;

procedure TDXPColors.SetClickedTo(Value: TColor);
begin
  if FClickedTo <> Value then
    FClickedTo := Value;
end;

procedure TDXPColors.SetFocusedFrom(Value: TColor);
begin
  if FFocusedFrom <> Value then
    FFocusedFrom := Value;
end;

procedure TDXPColors.SetFocusedTo(Value: TColor);
begin
  if FFocusedTo <> Value then
    FFocusedTo := Value;
end;

procedure TDXPColors.SetHighlightFrom(Value: TColor);
begin
  if FHighlightFrom <> Value then
    FHighlightFrom := Value;
end;

procedure TDXPColors.SetHighlightTo(Value: TColor);
begin
  if FHighlightTo <> Value then
    FHighlightTo := Value;
end;

procedure TDXPColors.SetHotTrack(Value: TColor);
begin
  if FHotTrack <> Value then
    FHotTrack := Value;
end;

end.
