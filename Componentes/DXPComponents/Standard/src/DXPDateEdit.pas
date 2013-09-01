unit DXPDateEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Graphics, Messages,
  Windows, CommCtrl, uIValidatable, Forms, DXPMessageOutPut,
  DXPUtils;

type
  // opRequired - Validar se foi preenchido;
  // opPrimaryKey - Desabilita quando o crud esta em estado de dsEdit;
  TOptions = set of TOption;
  //
  TDXPDateEdit = class(TCustomEdit, IValidatable)
  private
    FBaseColor: TColor;
    FOptions: TOptions;
    FMessageOutPut: TDXPMessageOutPut;
    FCaption: string;
    FReadOnly: Boolean;
    //
    FEstaDeletando: Boolean;
    //
    procedure SetValidations(const Value: TOptions);
    procedure SetMessageOutPut(const Value: TDXPMessageOutPut);
    procedure SetReadOnly(const Value: boolean);
    function GetDate: TDateTime;
    procedure SetDate(const Value: TDateTime);
    { Private declarations }
  protected
    procedure KeyPress(var Key: Char); override;
    procedure Change; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure DoSetTextHint(const Value: string); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    function IsValid: boolean;
    { Public declarations }
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkFlat;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle default bsNone;
    property Caption: string read FCaption write FCaption;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property Date: TDateTime read GetDate write SetDate;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property MessageOutPut: TDXPMessageOutPut read FMessageOutPut write SetMessageOutPut;
    property NumbersOnly;
    property OEMConvert;
    property Options: TOptions read FOptions write SetValidations;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly: boolean read FReadOnly write SetReadOnly default false;
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
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    { Published declarations }
  end;

implementation

{ TDXPDateEdit }

function TDXPDateEdit.GetDate: TDateTime;
var
  Data: TDateTime;
begin
  Result := 0;
  if ( Text <> '' ) and ( Text <> Name ) then
  begin
    try
      Data := StrToDate( Text );
      //
      Text := FormatDateTime('dd/mm/yyyy', Data);
      //
      Result := StrToDate( Text );
    except
      ShowMsgInformation( 'Data incorreta.' );
      TryFocus( Self );
    end;
  end;
end;

procedure TDXPDateEdit.Change;
begin
  inherited;
  if not( FEstaDeletando ) and ( Length( Text ) in [2,5] ) then
  begin
    Text     := Text + '/';
    SelStart := Length( Text );
  end;
end;

constructor TDXPDateEdit.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  //
  BorderStyle := bsNone;
  BevelKind   := bkFlat;
  FReadOnly   := false;
  MaxLength   := 10;
end;

destructor TDXPDateEdit.Destroy;
begin
  inherited Destroy;
end;

procedure TDXPDateEdit.DoEnter;
begin
  inherited;
  //
  FBaseColor := Color;
  Color := clInfoBk;
end;

procedure TDXPDateEdit.DoExit;
var
  Data: TDateTime;
  Converteu: Boolean;
begin
  if ( Trim( Text ) <> '' ) then
  begin
    Converteu := False;
    try
      Data := StrToDate( Text );
      //
      Text := FormatDateTime('dd/mm/yyyy', Data);
      //
      Converteu := True;
    except
      if Assigned( FMessageOutPut ) then
        FMessageOutPut.AddMessage( 'Data incorreta.', FCaption, Self )
      else
      begin
        ShowMsgInformation( 'Data incorreta.' );
        TryFocus( Self );
      end;
    end;
    //
    if not( Converteu ) then
      Exit;
  end;
  //
  Color := FBaseColor;
  //
  inherited DoExit;
end;

procedure TDXPDateEdit.DoSetTextHint(const Value: string);
begin
  {TODO -oAraujo -cComponents : Validar versão do windows}
  if CheckWin32Version( 5, 1 ) then
    SendTextMessage( Handle, EM_SETCUEBANNER, WPARAM(0), Value );
end;

function TDXPDateEdit.IsValid: boolean;
begin
  Result := false;
  //
  if ( opRequired in FOptions ) and ( Trim( Text ) = '' ) then
  begin
    if Assigned( FMessageOutPut ) then
      FMessageOutPut.AddMessage( 'Obrigatório.', FCaption, Self )
    else
    begin
      ShowMsgInformation( FCaption + ': Informação obrigatória.' );
      TryFocus( Self );
    end;
    //
    Exit;
  end;
  //
  Result := true;
end;

procedure TDXPDateEdit.KeyPress(var Key: Char);
begin
  inherited;
  FEstaDeletando := Key = #8;
end;

procedure TDXPDateEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification( AComponent, Operation );
  //
  if ( AComponent = FMessageOutPut ) and ( Operation = opRemove ) then
    FMessageOutPut := nil;
end;

procedure TDXPDateEdit.SetDate(const Value: TDateTime);
begin
  if ( Value <> 0 ) then
    Text := FormatDateTime('dd/mm/yyyy', Value)
  else
    Text := '';
end;

procedure TDXPDateEdit.SetMessageOutPut(const Value: TDXPMessageOutPut);
begin
  if Assigned( FMessageOutPut ) then
    FMessageOutPut.RemoveFreeNotification( Self );
  //
  FMessageOutPut := Value;
  //
  if Assigned( FMessageOutPut ) then
    FMessageOutPut.FreeNotification( Self );
end;

procedure TDXPDateEdit.SetReadOnly(const Value: boolean);
begin
  inherited ReadOnly := Value;
  FReadOnly := Value;
  //
  if FReadOnly then
    Color := clBtnFace
  else
    Color := clWindow;
end;

procedure TDXPDateEdit.SetValidations(const Value: TOptions);
begin
  if Value <> FOptions then
    FOptions := Value;
end;

end.
