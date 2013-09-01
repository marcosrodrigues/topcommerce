unit DXPSelect;

interface

uses
  Classes, Controls, StdCtrls, ExtCtrls, DB, DBClient, SysUtils, DXPSelectBrowser,
  Windows, Graphics, Messages, CommCtrl, Forms, DXPEdit, DXPMaskEdit;

type
  TDXPSelect = class(TCustomButtonedEdit)
  private
    FBaseColor: TColor;
    FSelectBrowser: TFrmDXPSelectBrowser;
    FDataSource: TDataSource;
    FEdit: TCustomEdit;
    FFieldCaption: string;
    FFieldKey: string;
    FKey: string;
    FKeyValue: string;
    FImageList: TImageList;
    FOnOpenDataSet: TNotifyEvent;
    FOnSelect: TNotifyEvent;
    FOnClearEdits: TNotifyEvent;
    FReadOnly: boolean;
    procedure SetReadOnly(const Value: boolean);
    //
    property Images;
    //
    procedure SetDataSource(const Value: TDataSource);
    //
    procedure OnRightClick(Sender: TObject);
    procedure OnSelectExit(Sender: TObject);
    procedure OnEditExit(Sender: TObject);
    procedure OnSelectKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnSelectKeyPress(Sender: TObject; var Key: Char);
    //
    procedure SearchByCaption;
    procedure ShowSelectBrowser;
    procedure Select(Sender: TObject);
    procedure ClearEdits(Sender: TObject);
    { Private declarations }
  protected
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ExitKey(Sender: TObject);

    property KeyValue: string read FKeyValue write FKeyValue;
    { Public declarations }
  published
    property OnOpenDataSet: TNotifyEvent read FOnOpenDataSet write FOnOpenDataSet;
    property OnSelect: TNotifyEvent read FOnSelect write FOnSelect;
    property OnClearEdits: TNotifyEvent read FOnClearEdits write FOnClearEdits;
    //
    property FieldCaption: string read FFieldCaption write FFieldCaption;
    property FieldKey: string read FFieldKey write FFieldKey;
    property Key: string read FKey write FKey;
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property Edit: TCustomEdit read FEdit write FEdit;
    //
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property LeftButton;
    property MaxLength;
    property OEMConvert;
    property NumbersOnly;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly: boolean read FReadOnly write SetReadOnly default false;
    property RightButton;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property TextHint;
    property Touch;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnGesture;
    property OnLeftButtonClick;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnRightButtonClick;
    property OnStartDock;
    property OnStartDrag;
    { Published declarations }
  end;

implementation

uses udmRepository;

{ TDXPSelect }

procedure TDXPSelect.ClearEdits(Sender: TObject);
begin
  FEdit.Clear;
  Self.Clear;

  if Assigned( FOnClearEdits ) then
    FOnClearEdits( Sender );
end;

constructor TDXPSelect.Create(AOwner: TComponent);
var
  Repository: TdmRepository;
begin
  inherited Create( AOwner );
  //
  FImageList := TImageList.Create( Self );
  //
  Repository := TdmRepository.Create( nil );
  //
  try
    FImageList.AddImages(Repository.imgAll);
  finally
    Repository.Free;
  end;
  //
  Self.Images := FImageList;
  Self.LeftButton.Visible     := True;
  Self.LeftButton.ImageIndex  := 1;
  Self.RightButton.Visible    := True;
  Self.RightButton.ImageIndex := 2;
  //Self.TextHint               := 'Selecione...';
  Self.BorderStyle            := bsNone;
  Self.BevelKind              := bkFlat;
  //
  Self.OnRightButtonClick  := OnRightClick;
  Self.OnExit              := OnSelectExit;
  Self.OnKeyDown           := OnSelectKeyDown;
  Self.OnKeyPress          := OnSelectKeyPress;
  //
  FSelectBrowser          := TFrmDXPSelectBrowser.Create( Self );
  FSelectBrowser.OnSelect := Select;
end;

destructor TDXPSelect.Destroy;
begin
  FSelectBrowser.Free;
  FImageList.Free;
  inherited;
end;

procedure TDXPSelect.ExitKey(Sender: TObject);
begin
  if ( FKeyValue = '' ) then
  begin
    ClearEdits( Sender );
    Exit;
  end;

  if ( FKey = '' ) then
    raise Exception.Create( 'Não foi informado o field para o Id' );
  //
  FOnOpenDataSet(Self);
  //
  FDataSource.DataSet.Filtered := False;
  FDataSource.DataSet.Filter   := 'UPPER(' + FKey + ') = ' + QuotedStr( FKeyValue );
  FDataSource.DataSet.Filtered := True;
  if FDataSource.DataSet.RecordCount > 0 then
  begin
    if ( FFieldCaption = '' ) then
      raise Exception.Create( 'Não foi informado o Field para o caption.' );

    Select( Self );
    Self.Text  := FDataSource.DataSet.FieldByName( FFieldCaption ).AsString;
  end
  else
  begin
    FEdit.Clear;
    FEdit.SetFocus;
  end;
  Self.DataSource.DataSet.Filtered := False;
end;

procedure TDXPSelect.DoEnter;
begin
  inherited;
  //
  FBaseColor := Color;
  Color := clInfoBk;
end;

procedure TDXPSelect.DoExit;
begin
  Color := FBaseColor;
  //
  inherited;
end;

procedure TDXPSelect.Loaded;
begin
  inherited;
  FSelectBrowser.EditKey := FEdit;
  FSelectBrowser.Key     := FFieldKey;
  FSelectBrowser.Caption := FFieldCaption;
  //
  if Assigned( FEdit ) and not( csDesigning in ComponentState ) then
  begin
    if ( FEdit is TDXPEdit ) then
      ( FEdit as TDXPEdit ).OnExit := OnEditExit
    else if ( FEdit is TDXPMaskEdit ) then
      ( FEdit as TDXPMaskEdit ).OnExit := OnEditExit
  end;
end;

procedure TDXPSelect.OnEditExit(Sender: TObject);
begin
  if ( FEdit is TDXPEdit ) then
  begin
    if ( Trim( ( FEdit as TDXPEdit ).Text ) = '' ) then
      Exit;
  end
  else if ( FEdit is TDXPMaskEdit ) then
  begin
    if ( Trim( ( FEdit as TDXPMaskEdit ).Text ) = '' ) then
      Exit;
  end;
  //
  if ( FFieldKey = '' ) then
    raise Exception.Create( 'Não foi informado o field para o Id' );
  //
  FOnOpenDataSet(Self);
  //
  FDataSource.DataSet.Filtered := False;
  if ( FEdit is TDXPEdit ) then
    FDataSource.DataSet.Filter := 'UPPER(' + FFieldKey + ') = ' + QuotedStr( UpperCase(( FEdit as TDXPEdit ).Text) )
  else if ( FEdit is TDXPMaskEdit ) then
    FDataSource.DataSet.Filter := 'UPPER(' + FFieldKey + ') = ' + QuotedStr( UpperCase(( FEdit as TDXPMaskEdit ).Text) );
  FDataSource.DataSet.Filtered := True;
  if FDataSource.DataSet.RecordCount > 0 then
  begin
    if ( FFieldCaption = '' ) then
      raise Exception.Create( 'Não foi informado o Field para o caption.' );

    Select( Self );
    Self.Text  := FDataSource.DataSet.FieldByName( FFieldCaption ).AsString;
  end
  else
  begin
    FEdit.Clear;
    FEdit.SetFocus;
  end;
  Self.DataSource.DataSet.Filtered := False;
end;

procedure TDXPSelect.OnSelectExit(Sender: TObject);
begin
  if Self.Text <> '' then
    SearchByCaption
  else if FEdit.Text <> '' then
    OnEditExit(Sender);
end;

procedure TDXPSelect.OnSelectKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_NEXT, VK_DOWN: ShowSelectBrowser;
  end;
end;

procedure TDXPSelect.OnSelectKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
    SearchByCaption;
end;

procedure TDXPSelect.OnRightClick(Sender: TObject);
begin
  ShowSelectBrowser;
end;

procedure TDXPSelect.SearchByCaption;
begin
  if ( FFieldCaption = '' ) then
    raise Exception.Create( 'Não foi informado o Field para o caption.' );
  //
  FOnOpenDataSet(Self);
  //
  FDataSource.DataSet.Filtered := False;
  FDataSource.DataSet.Filter   := 'UPPER(' + FFieldCaption + ') LIKE ' + QuotedStr('%' + UpperCase(Self.Text) + '%');
  FDataSource.DataSet.Filtered := True;
  if FDataSource.DataSet.RecordCount > 1 then
    FSelectBrowser.ShowBrowser
  else
  begin
    if ( FFieldKey = '' ) then
      raise Exception.Create( 'Não foi informado o field para o Id' );

    Select( Self );
    Self.Text  := FDataSource.DataSet.FieldByName( FFieldCaption ).AsString;
  end;
end;

procedure TDXPSelect.Select(Sender: TObject);
begin
  if ( FEdit is TDXPEdit ) then
    ( FEdit as TDXPEdit ).Text := FDataSource.DataSet.FieldByName( FFieldKey ).AsString
  else if ( FEdit is TDXPMaskEdit ) then
    ( FEdit as TDXPMaskEdit ).Text := FDataSource.DataSet.FieldByName( FFieldKey ).AsString;

  FKeyValue := FDataSource.DataSet.FieldByName( FKey ).AsString;

  if ( Assigned( FOnSelect ) ) then
    FOnSelect( Sender );
end;

procedure TDXPSelect.SetDataSource(const Value: TDataSource);
begin
  if not( csDesigning in ComponentState ) and Assigned( Value.DataSet ) and not( Value.DataSet is TClientDataSet ) then
    raise Exception.Create( 'Dataset from datasource is not a TClientDataSet' );
  //
  FDataSource := Value;
  //
  if not( csDesigning in ComponentState ) and Assigned( FDataSource ) then
    FSelectBrowser.grdSelectBrowser.DataSource := FDataSource;
end;

procedure TDXPSelect.SetReadOnly(const Value: boolean);
begin
  inherited ReadOnly := Value;
  FReadOnly := Value;
  //
  if FReadOnly then
    Color := clBtnFace
  else
    Color := clWindow;
end;

procedure TDXPSelect.ShowSelectBrowser;
begin
  if not( Assigned( FDataSource ) ) then
    raise Exception.Create( 'Nenhum DataSource foi ligado ao DXPSelect.' );
  //
  if FSelectBrowser.Visible then
    FSelectBrowser.Close
  else
  begin
    FOnOpenDataSet(Self);
    FSelectBrowser.ShowBrowser;
  end;
end;

end.
