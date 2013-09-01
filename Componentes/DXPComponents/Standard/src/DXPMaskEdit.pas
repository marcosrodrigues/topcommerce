unit DXPMaskEdit;

interface

uses
  Mask, Graphics, Classes, SysUtils, Messages, CommCtrl, Windows, Forms, Controls,
  uIValidatable, DXPMessageOutPut, DXPUtils;

type
  // opRequired - Validar se foi preenchido;
  // opDate - MaskEdit para datas
  TOptions = set of TOption;
  //
  TDXPMaskEdit = class(TCustomMaskEdit, IValidatable)
  private
    FBaseColor: TColor;
    FOptions: TOptions;
    FMessageOutPut: TDXPMessageOutPut;
    FCaption: string;
    FReadOnly: boolean;
    //
    procedure SetValidations(const Value: TOptions);
    procedure SetMessageOutPut(const Value: TDXPMessageOutPut);
    procedure SetReadOnly(const Value: boolean);
    { Private declarations }
  protected
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
    procedure ValidateEdit; override;
    { Public declarations }
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkFlat;
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
    property EditMask;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property MessageOutPut: TDXPMessageOutPut read FMessageOutPut write SetMessageOutPut;
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

{ TDXPMaskEdit }

procedure TDXPMaskEdit.SetValidations(const Value: TOptions);
begin
  if Value <> FOptions then
    FOptions := Value;
end;

procedure TDXPMaskEdit.ValidateEdit;
begin
  
end;

procedure TDXPMaskEdit.SetMessageOutPut(const Value: TDXPMessageOutPut);
begin
  if Assigned( FMessageOutPut ) then
    FMessageOutPut.RemoveFreeNotification( Self );
  //
  FMessageOutPut := Value;
  //
  if Assigned( FMessageOutPut ) then
    FMessageOutPut.FreeNotification( Self );
end;

procedure TDXPMaskEdit.SetReadOnly(const Value: boolean);
begin
  inherited ReadOnly := Value;
  FReadOnly := Value;
  //
  if FReadOnly then
    Color := clBtnFace
  else
    Color := clWindow;
end;

procedure TDXPMaskEdit.DoEnter;
begin
  inherited;
  //
  FBaseColor := Color;
  Color := clInfoBk;
end;

procedure TDXPMaskEdit.DoExit;
begin
  Color := FBaseColor;
  //
  inherited DoExit;
end;

procedure TDXPMaskEdit.DoSetTextHint(const Value: string);
begin
  {TODO -oAraujo -cComponents : Validar versão do windows}
  if CheckWin32Version( 5, 1 ) then
    SendTextMessage( Handle, EM_SETCUEBANNER, WPARAM(0), Value );
end;

procedure TDXPMaskEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification( AComponent, Operation );
  //
  if ( AComponent = FMessageOutPut ) and ( Operation = opRemove ) then
    FMessageOutPut := nil;
end;

constructor TDXPMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  //
  BorderStyle := bsNone;
  BevelKind   := bkFlat;
  FReadOnly   := false;
end;

destructor TDXPMaskEdit.Destroy;
begin
  inherited Destroy;
end;

function TDXPMaskEdit.IsValid: boolean;
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
  Result := True;
end;

end.
