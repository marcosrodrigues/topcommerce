unit DXPMessageOutPut;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls, Graphics, Types,
  Windows, Forms, ComCtrls, DXPPanelDegrade, StdCtrls,
  udmRepository, Buttons, Generics.Collections, StrUtils;

type
  TOutPutStyle = (lsList, lsTreeView);
  //
  TDXPMessageOutPut = class(TWinControl)
  private
    FPanelDegrade: TDXPPanelDegrade;
    FListOutPut: TListView;
    FTreeViewOutPut: TTreeView;
    FLastSearchTreeNode: TTreeNode;
    FButtonClose: TSpeedButton;
    FHeightSetting: integer;
    FTimer: TTimer;
    FActive: boolean;
    FShowingOutPut: boolean;
    FOutPutStyle: TOutPutStyle;
    FHeightShow: integer;
    FExpandAllOnShow: boolean;
    //
    procedure SetFocusItemList;
    //
    procedure AddMessageList(const aMsg, aCaption: string); overload;
    procedure AddMessageList(const aMsg, aCaption: string; aFocusControl: TWinControl); overload;
    procedure AddMessageTreeView(const aMsg, aCaption: string); overload;
    procedure AddMessageTreeView(const aMsg, aCaption: string; aFocusControl: TWinControl); overload;
    function GetItemTreeView(const aCaption: string): TTreeNode;
    //
    procedure OnClickButtonClose(Sender: TObject);
    procedure OnTimer(Sender: TObject);
    procedure OnListDblClick(Sender: TObject);
    procedure OnTreeViewDblClick(Sender: TObject);
    procedure OnListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnTreeViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnListResize(Sender: TObject);
    //
    procedure SetListStyle(const Value: TOutPutStyle);
    procedure SetHeightShow(const Value: integer);
    { Private declarations }
  protected
    procedure Loaded; override;
    { Protected declarations }
  public
    property ShowingOutPut: boolean read FShowingOutPut;
    property HeightShow: integer read FHeightShow write SetHeightShow;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    procedure AddMessage(const aMsg, aCaption: string); overload;
    procedure AddMessage(const aMsg, aCaption: string; aFocusControl: TWinControl); overload; {TODO -oAraujo -cComponent : Implementar o TryFocus, se nao conseguir manda o focu dispara uma notifyevent OnTryFocusFail}
    procedure ShowOutPut;
    procedure ClearOutPut;
    procedure Close;
    { Public declarations }
  published
    property Active: boolean read FActive write FActive default true;
    property ExpandAllOnShow: boolean read FExpandAllOnShow write FExpandAllOnShow default false;
    property Height default 90;
    property OutPutStyle: TOutPutStyle read FOutPutStyle write SetListStyle default lsList;
    { Published declarations }
  end;

implementation

{ TDXPMessageOutPut }

procedure TDXPMessageOutPut.AddMessage(const aMsg, aCaption: string);
begin
  if FOutPutStyle = lsList then
    AddMessageList( aMsg, aCaption )
  else
    AddMessageTreeView( aMsg, aCaption );
end;

procedure TDXPMessageOutPut.AddMessage(const aMsg, aCaption: string; aFocusControl: TWinControl);
begin
  if FOutPutStyle = lsList then
    AddMessageList( aMsg, aCaption, aFocusControl )
  else
    AddMessageTreeView( aMsg, aCaption, aFocusControl );
end;

procedure TDXPMessageOutPut.AddMessageList(const aMsg, aCaption: string);
begin
  FListOutPut.Items.Add.Caption := IfThen( Trim( aCaption ) <> '', aCaption + ' - ' ) + aMsg;
end;

procedure TDXPMessageOutPut.AddMessageList(const aMsg, aCaption: string; aFocusControl: TWinControl);
var
  PFocusControl: ^TWinControl;
  NewItem: TListItem;
begin
  New( PFocusControl );
  //
  NewItem         := FListOutPut.Items.Add;
  NewItem.Caption := IfThen( Trim( aCaption ) <> '', aCaption + ' - ' ) + aMsg;
  PFocusControl^  := aFocusControl;
  NewItem.Data    := PFocusControl;
end;

procedure TDXPMessageOutPut.AddMessageTreeView(const aMsg, aCaption: string);
var
  Node: TTreeNode;
begin
  Node := GetItemTreeView( aCaption );
  //
  // No Pai;
  if Node = nil then
    Node := FTreeViewOutPut.Items.AddObject( nil, aCaption, nil );
  //
  FTreeViewOutPut.Items.AddChildObject( Node, aMsg, nil );
end;

procedure TDXPMessageOutPut.AddMessageTreeView(const aMsg, aCaption: string; aFocusControl: TWinControl);
var
  PFocusControl: ^TWinControl;
  Node: TTreeNode;
begin
  New( PFocusControl );
  PFocusControl^ := aFocusControl;
  //
  Node := GetItemTreeView( aCaption );
  //
  // No Pai;
  if Node = nil then
    Node := FTreeViewOutPut.Items.AddObject( nil, aCaption, PFocusControl );
  //
  FTreeViewOutPut.Items.AddChildObject( Node, aMsg, PFocusControl );
  Node.Expanded := FExpandAllOnShow;
end;

procedure TDXPMessageOutPut.ClearOutPut;
begin
  FListOutPut.Items.Clear;
  FTreeViewOutPut.Items.Clear;
end;

procedure TDXPMessageOutPut.Close;
begin
  Height         := 0;
  FShowingOutPut := false;
  TabStop        := false;
end;

constructor TDXPMessageOutPut.Create(AOwner: TComponent);
var
  bmp: Graphics.TBitmap;
  Repository: TdmRepository;
begin
  inherited Create( AOwner );
  //
  Align            := alBottom;
  FActive          := true;
  Height           := 90;
  FShowingOutPut   := false;
  TabStop          := false;
  FOutPutStyle     := lsList;
  FExpandAllOnShow := false;
  //
  if ( not( csDesigning in ComponentState ) and not( FActive ) ) then
    Visible := false;
  //
  FPanelDegrade            := TDXPPanelDegrade.Create( Self );
  FPanelDegrade.Parent     := Self;
  FPanelDegrade.Align      := alTop;
  FPanelDegrade.Height     := 21;
  FPanelDegrade.Color      := clGray;
  FPanelDegrade.BackGround := clWindow;
  FPanelDegrade.Alignment  := taLeftJustify;
  FPanelDegrade.Caption    := '  Mensagens...';
  FPanelDegrade.Font.Style := [fsBold];
  //
  bmp := Graphics.TBitmap.Create;
  Repository := TdmRepository.Create( nil );
  //
  try
    Repository.imgAll.GetBitmap( 0, bmp );
  finally
    Repository.Free;
  end;
  //
  FButtonClose          := TSpeedButton.Create( FPanelDegrade );
  FButtonClose.Parent   := FPanelDegrade;
  FButtonClose.Flat     := true;
  FButtonClose.Align    := alRight;
  FButtonClose.Height   := 18;
  FButtonClose.Width    := 18;
  FButtonClose.Glyph    := bmp;
  FButtonClose.Hint     := 'Fechar';
  FButtonClose.ShowHint := true;
  FButtonClose.OnClick  := OnClickButtonClose;
  FreeAndNil( bmp );
  //
  FTreeViewOutPut             := TTreeView.Create( Self );
  FTreeViewOutPut.Parent      := Self;
  FTreeViewOutPut.Align       := alClient;
  FTreeViewOutPut.BorderStyle := bsNone;
  FTreeViewOutPut.OnDblClick  := OnTreeViewDblClick;
  FTreeViewOutPut.OnKeyDown   := OnTreeViewKeyDown;
  //
  FListOutPut                   := TListView.Create( Self );
  FListOutPut.Parent            := Self;
  FListOutPut.Align             := alClient;
  FListOutPut.BorderStyle       := bsNone;
  FListOutPut.Columns.Add.Width := FListOutPut.Width - 10;
  FListOutPut.RowSelect         := true;
  FListOutPut.ShowColumnHeaders := false;
  FListOutPut.ViewStyle         := vsReport;
  FListOutPut.OnDblClick        := OnListDblClick;
  FListOutPut.OnKeyDown         := OnListKeyDown;
  FListOutPut.OnResize          := OnListResize;
  //
  FTimer          := TTimer.Create( Self );
  FTimer.Enabled  := false;
  FTimer.Interval := 10;
  FTimer.OnTimer  := OnTimer;
end;

destructor TDXPMessageOutPut.Destroy;
var
  I: integer;
begin
  FButtonClose.Glyph := nil;
  //
  for I := 0 to FTreeViewOutPut.Items.Count - 1 do
    FTreeViewOutPut.Items[I].Data := nil;
  //
  for I := 0 to FListOutPut.Items.Count - 1 do
    FListOutPut.Items[I].Data := nil;
  //
  inherited Destroy;
end;

function TDXPMessageOutPut.GetItemTreeView(const aCaption: string): TTreeNode;
begin
  Result := nil;
  FLastSearchTreeNode := FTreeViewOutPut.Items.GetFirstNode;
  //
  repeat
    if FLastSearchTreeNode = nil then
      Break;
    //
    if FLastSearchTreeNode.Text = aCaption then
    begin
      Result := FLastSearchTreeNode;
      Break;
    end
    else
      FLastSearchTreeNode := FLastSearchTreeNode.getNextSibling;
  until false;
end;

procedure TDXPMessageOutPut.Loaded;
begin
  inherited Loaded;
  //
  if not( csDesigning in ComponentState ) then
  begin
    if Self.Height = 0 then
      FHeightSetting := 90
    else
      FHeightSetting := Self.Height;
    //
    Self.Height := 0;
  end;
  //
  FListOutPut.Visible     := ( FOutPutStyle = lsList );
  FTreeViewOutPut.Visible := ( FOutPutStyle = lsTreeView );
end;

procedure TDXPMessageOutPut.OnClickButtonClose(Sender: TObject);
begin
  Close;
end;

procedure TDXPMessageOutPut.OnListDblClick(Sender: TObject);
begin
  SetFocusItemList;
end;

procedure TDXPMessageOutPut.OnListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Ord( Key ) = 13 then
    SetFocusItemList;
end;

procedure TDXPMessageOutPut.OnListResize(Sender: TObject);
begin
  FListOutPut.Columns[0].Width := FListOutPut.Width - 20;
end;

procedure TDXPMessageOutPut.OnTimer(Sender: TObject);
begin
  if Height > FHeightSetting then
  begin
    FTimer.Enabled := false;
    FShowingOutPut := true;
    TabStop        := true;
    Exit;
  end;
  //
  Height := Height + 10;
end;

procedure TDXPMessageOutPut.OnTreeViewDblClick(Sender: TObject);
begin
  SetFocusItemList;
end;

procedure TDXPMessageOutPut.OnTreeViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Ord( Key ) = 13 then
    SetFocusItemList;
end;

procedure TDXPMessageOutPut.SetFocusItemList;
begin
  if FOutPutStyle = lsList then
  begin
    if FListOutPut.Items.Count > 0 then
      if FListOutPut.ItemIndex <> -1 then
        if Assigned( FListOutPut.Selected.Data ) then
          TWinControl( FListOutPut.Selected.Data^ ).SetFocus;
  end
  else
  begin
    if FTreeViewOutPut.Items.Count > 0 then
      if ( FTreeViewOutPut.Selected <> nil ) and ( FTreeViewOutPut.Selected.Index <> -1 ) then
        if Assigned( FTreeViewOutPut.Selected.Data ) then
          TWinControl( FTreeViewOutPut.Selected.Data^ ).SetFocus;
  end;
end;

procedure TDXPMessageOutPut.SetHeightShow(const Value: integer);
begin
  FHeightShow := Value;
  FHeightSetting := Value;
end;

procedure TDXPMessageOutPut.SetListStyle(const Value: TOutPutStyle);
begin
  FOutPutStyle := Value;
  //
  FListOutPut.Visible     := ( Value = lsList );
  FTreeViewOutPut.Visible := ( Value = lsTreeView );
end;

procedure TDXPMessageOutPut.ShowOutPut;
begin
  FTimer.Enabled := FActive;
end;

end.
