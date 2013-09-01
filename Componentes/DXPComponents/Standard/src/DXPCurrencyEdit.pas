unit DXPCurrencyEdit;

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
  TDXPCurrencyEdit = class(TCustomEdit, IValidatable)
  private
    FBaseColor: TColor;
    FOptions: TOptions;
    FMessageOutPut: TDXPMessageOutPut;
    FCaption: string;
    FReadOnly: Boolean;
    //
    procedure SetValidations(const Value: TOptions);
    procedure SetMessageOutPut(const Value: TDXPMessageOutPut);
    procedure SetReadOnly(const Value: boolean);
    function GetValue: Currency;
    procedure SetValue(const Value: Currency);
    { Private declarations }
  protected
    procedure KeyPress(var Key: Char); override;
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
    property Value: Currency read GetValue write SetValue;
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

{ TDXPCurrencyEdit }

function TDXPCurrencyEdit.GetValue: Currency;
begin
  Result := 0;
  if ( Text <> '' ) and ( Text <> Name ) then
  begin
    try
      Result := StrToCurr( Text );
    except
      ShowMsgInformation( 'Valor incorreto.' );
      TryFocus( Self );
    end;
  end;
end;

constructor TDXPCurrencyEdit.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  //
  BorderStyle := bsNone;
  BevelKind   := bkFlat;
  FReadOnly   := false;
  Alignment   := taRightJustify;
  Value       := 0;
end;

destructor TDXPCurrencyEdit.Destroy;
begin
  inherited Destroy;
end;

procedure TDXPCurrencyEdit.DoEnter;
begin
  inherited;
  //
  FBaseColor := Color;
  Color := clInfoBk;
end;

procedure TDXPCurrencyEdit.DoExit;
var
  Value: Currency;
  Converteu: Boolean;
begin
  if ( Trim( Text ) <> '' ) then
  begin
    Converteu := False;
    try
      Value := StrToCurr( Text );
      //
      Text := FormatCurr(',0.00', Value);
      //
      Converteu := True;
      //
      //if FMessageOutPut.ShowingOutPut then
        //FMessageOutPut.Close;
    except
      if Assigned( FMessageOutPut ) then
      begin
        FMessageOutPut.ClearOutPut;
        FMessageOutPut.AddMessage( 'Valor incorreto.', FCaption, Self );
        FMessageOutPut.ShowOutPut;
      end
      else
      begin
        ShowMsgInformation( 'Valor incorreto.' );
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

procedure TDXPCurrencyEdit.DoSetTextHint(const Value: string);
begin
  {TODO -oAraujo -cComponents : Validar versão do windows}
  if CheckWin32Version( 5, 1 ) then
    SendTextMessage( Handle, EM_SETCUEBANNER, WPARAM(0), Value );
end;

function TDXPCurrencyEdit.IsValid: boolean;
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

procedure TDXPCurrencyEdit.KeyPress(var Key: Char);
begin
  inherited;
  //
  if not( CharInSet(Key, ['0'..'9',',',#8,#13] ) ) then
    Key := #0;
end;

procedure TDXPCurrencyEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification( AComponent, Operation );
  //
  if ( AComponent = FMessageOutPut ) and ( Operation = opRemove ) then
    FMessageOutPut := nil;
end;

procedure TDXPCurrencyEdit.SetValue(const Value: Currency);
begin
  Text := FormatCurr(',0.00', Value);
end;

procedure TDXPCurrencyEdit.SetMessageOutPut(const Value: TDXPMessageOutPut);
begin
  if Assigned( FMessageOutPut ) then
    FMessageOutPut.RemoveFreeNotification( Self );
  //
  FMessageOutPut := Value;
  //
  if Assigned( FMessageOutPut ) then
    FMessageOutPut.FreeNotification( Self );
end;

procedure TDXPCurrencyEdit.SetReadOnly(const Value: boolean);
begin
  inherited ReadOnly := Value;
  FReadOnly := Value;
  //
  if FReadOnly then
    Color := clBtnFace
  else
    Color := clWindow;
end;

procedure TDXPCurrencyEdit.SetValidations(const Value: TOptions);
begin
  if Value <> FOptions then
    FOptions := Value;
end;

end.
