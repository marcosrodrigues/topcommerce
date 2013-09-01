{ ****
  Descrição: Classe Base para controles baseados em RIA.
  Co-Autor: Araújo
  Observação: Toda ideia inicial foi retirada da Design eXperience, todos
              os direitos de autoria reservados, sendo que na sua nota
              de desenvolvimento tem especificando o direito de uso em
              Software FreeWare ou Comercial.
{*******************************************************************}
{   Copyright (c) 2002 APRIORI business solutions AG                }
{   (W)ritten by M. Hoffmann - ALL RIGHTS RESERVED.                 }
{                                                                   }
{   DEVELOPER NOTES:                                                }
{   ==========================================================      }
{   This file is part of a component suite called Design            }
{   eXperience and may be used in freeware- or commercial           }
{   applications. The package itself is distributed as              }
{   freeware with full sourcecodes.                                 }
{                                                                   }
{   Contact: mhoffmann@apriori.de                                   }
{*******************************************************************}

unit DXPControl;

interface

uses
  Windows, Messages, Classes, Controls, Graphics, Forms, DXPCommonTypes;

type
{ forward declarations }
  TDXPCustomStyleControl = class;

  { TDXPCustomComponent
    baseclass for non-focusable component descendants. }
  TDXPCustomComponent = class(TComponent)
  private
    FVersion: string;
    procedure SetVersion(Value: string);
    { Private desclarations }
  protected
    { Protected desclarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public desclarations }
  published
    property Version: string read FVersion write SetVersion stored false;
    { Published desclarations }
  end;

{ TDXPWinControl }
  TDXPWinControl = class(TWinControl)
  published
    property Color;
    { Published declarations }
  end;

{ TDXPCustomControl
  baseclass for focusable control descendants. }
  TDXPCustomControl = class(TCustomControl)
  private
    FClicking: Boolean;
    FDrawState: TDXPDrawState;
    FIsLocked: Boolean;
    FIsSibling: Boolean;
    FModalResult: TModalResult;
    FVersion: string;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    //
    procedure SetVersion(Value: string);
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMBorderChanged(var Message: TMessage); message CM_BORDERCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFocusChanged(var Message: TMessage); message CM_FOCUSCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    { Private desclarations }
  protected
    FExControlStyle: TDXPControlStyle;
    //
    procedure InternalRedraw; dynamic;
    procedure HookBorderChanged; dynamic;
    procedure HookEnabledChanged; dynamic;
    procedure HookFocusedChanged; dynamic;
    procedure HookMouseDown; dynamic;
    procedure HookMouseEnter; dynamic;
    procedure HookMouseLeave; dynamic;
    procedure HookMouseMove(X: Integer = 0; Y: Integer = 0); dynamic;
    procedure HookMouseUp; dynamic;
    procedure HookParentColorChanged; dynamic;
    procedure HookParentFontChanged; dynamic;
    procedure HookPosChanged; dynamic;
    procedure HookResized; dynamic;
    procedure HookTextChanged; dynamic;
    procedure MouseDown(Button:TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button:TMouseButton; Shift:TShiftState; X, Y: Integer); override;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    { Protected desclarations }
  public
    property Canvas;
    property DrawState: TDXPDrawState read FDrawState write FDrawState;
    property IsLocked: Boolean read FIsLocked write FIsLocked;
    property IsSibling: Boolean read FIsSibling write FIsSibling;
    //
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
    procedure BeginUpdate; dynamic;
    procedure EndUpdate; dynamic;
    procedure Redraw;
    { Public desclarations }
  published
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Version: string read FVersion write SetVersion stored false;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    { Published declarations }
  end;

{ TDXPUnlimitedControl }
  TDXPUnlimitedControl = class(TDXPCustomControl);

{ TDXPStyle }
  TDXPStyle = class(TPersistent)
  private
    FTheme: TDXPTheme;
    FUseStyleManager: Boolean;
    { Private declarations }
  protected
    Parent: TDXPCustomStyleControl;
    //
    procedure SetTheme(Value: TDXPTheme); virtual;
    procedure SetUseStyleManager(Value: Boolean); virtual;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent);
    function GetTheme: TDXPTheme;
    { Public declarations }
  published
    property Theme: TDXPTheme read FTheme write SetTheme default WindowsXP;
    property UseStyleManager: Boolean read FUseStyleManager write SetUseStyleManager default true;
    { Published declarations }
  end;

{ TDXPStyleManager }
  TDXPStyleManager = class(TDXPCustomComponent)
  private
    FControls: TList;
    FTheme: TDXPTheme;
    FOnThemeChanged: TNotifyEvent;
    //
    procedure InvalidateControls;
    { Private declarations }
  protected
    procedure SetTheme(Value: TDXPTheme); virtual;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RegisterControls(const AControls: array of TDXPCustomControl);
    procedure UnregisterControls(const AControls: array of TDXPCustomControl);
    { Public declarations }
  published
    property Theme: TDXPTheme read FTheme write SetTheme default WindowsXP;
    property OnThemeChanged: TNotifyEvent read FOnThemeChanged write FOnThemeChanged;
    { Published declarations }
  end;

{ TDXPCustomStyleControl }
  TDXPCustomStyleControl = class(TDXPCustomControl)
  private
    FStyle: TDXPStyle;
    FStyleManager: TDXPStyleManager;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  protected
    procedure SetStyleManager(Value: TDXPStyleManager); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Protected declarations }
  published
    property Style: TDXPStyle read FStyle write FStyle;
    property StyleManager: TDXPStyleManager read FStyleManager write SetStyleManager;
    { Published declarations }
  end;

implementation

uses
  DXPUtils;

resourcestring
  SVersion = '1.0';

{ TDXPCustomComponent }

constructor TDXPCustomComponent.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  FVersion := 'DXP Components ' + SVersion;
end;

procedure TDXPCustomComponent.SetVersion(Value: string);
begin
  ; // don't enable overwriting this constant.
end;

{ TDXPCustomControl }

constructor TDXPCustomControl.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  //
  ControlStyle    := ControlStyle + [csOpaque, csReplicatable];
  DoubleBuffered  := true;
  //
  FExControlStyle := [csRedrawEnabledChanged, csRedrawFocusedChanged,
    csRedrawMouseDown, csRedrawMouseEnter, csRedrawMouseLeave, csRedrawMouseUp,
    csRedrawParentColorChanged, csRedrawCaptionChanged];
  //
  FClicking    := false;
  FDrawState   := [dsDefault];
  FIsLocked    := false;
  FIsSibling   := false;
  FModalResult := 0;
  FVersion     := 'DXP Components ' + SVersion;
end;

procedure TDXPCustomControl.SetVersion(Value: string);
begin
  ; // disallow changing this property.
end;

procedure TDXPCustomControl.BeginUpdate;
begin
  FIsLocked := true;
end;

procedure TDXPCustomControl.EndUpdate;
begin
  FIsLocked := false;
  InternalRedraw;
end;

procedure TDXPCustomControl.InternalRedraw;
begin
  if not( FIsLocked ) then
    Invalidate;
end;

procedure TDXPCustomControl.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel( CharCode, Caption ) and
       CanFocus and
       ( Focused or ( ( GetKeyState( VK_MENU ) and $8000 ) <> 0 ) ) then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TDXPCustomControl.CMBorderChanged(var Message: TMessage);
begin
  // deligate message "BorderChanged" to hook.
  inherited;
  HookBorderChanged;
end;

procedure TDXPCustomControl.CMEnabledChanged(var Message: TMessage);
begin
  // deligate message "EnabledChanged" to hook.
  inherited;
  HookEnabledChanged;
end;

procedure TDXPCustomControl.CMFocusChanged(var Message: TMessage);
begin
  // deligate message "FocusChanged" to hook.
  inherited;
  HookFocusedChanged;
end;

procedure TDXPCustomControl.CMMouseEnter(var Message: TMessage);
begin
  // deligate message "MouseEnter" to hook.
  inherited;
  HookMouseEnter;
end;

procedure TDXPCustomControl.CMMouseLeave(var Message: TMessage);
begin
  // deligate message "MouseLeave" to hook.
  inherited;
  HookMouseLeave;
end;

procedure TDXPCustomControl.CMParentColorChanged(var Message: TMessage);
begin
  // deligate message "ParentColorChanged" to hook.
  inherited;
  HookParentColorChanged;
end;

procedure TDXPCustomControl.CMParentFontChanged(var Message: TMessage);
begin
  // deligate message "ParentFontChanged" to hook.
  inherited;
  HookParentFontChanged;
end;

procedure TDXPCustomControl.CMTextChanged(var Message: TMessage);
begin
  // deligate message "TextChanged" to hook.
  inherited;
  HookTextChanged;
end;

procedure TDXPCustomControl.WMMouseMove(var Message: TWMMouse);
begin
  // deligate message "MouseMove" to hook.
  inherited;
  HookMouseMove(Message.XPos, Message.YPos);
end;

procedure TDXPCustomControl.WMSize(var Message: TWMSize);
begin
  // deligate message "Size" to hook.
  inherited;
  HookResized;
end;

procedure TDXPCustomControl.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  // deligate message "WindowPosChanged" to hook.
  inherited;
  HookPosChanged;
end;

procedure TDXPCustomControl.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // deligate message "MouseDown" to hook.
  inherited;
  if Button = mbLeft then
  begin
    FClicking := true;
    HookMouseDown;
  end;
end;

procedure TDXPCustomControl.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // deligate message "MouseUp" to hook.
  inherited;
  if FClicking then
  begin
    FClicking := false;
    HookMouseUp;
  end;
end;

procedure TDXPCustomControl.Redraw;
begin
  InternalRedraw;
end;

procedure TDXPCustomControl.Click;
var
  Form: TCustomForm;
begin
  Form := GetParentForm( Self );
  //
  if Form <> nil then
    Form.ModalResult := ModalResult;
  //
  inherited Click;
end;

//
// hooks are used to interrupt default windows messages in an easier
// way - it's possible to override them in descedant classes.
// Beware of multiple redraw calls - if you know that the calling
// hooks always redraws the component, use the lock i.e. unlock methods.
//

procedure TDXPCustomControl.HookBorderChanged;
begin
  // this hook is called, if the border property was changed.
  // in that case we normaly have to redraw the control.
  if csRedrawBorderChanged in FExControlStyle then
    InternalRedraw;
end;

procedure TDXPCustomControl.HookEnabledChanged;
begin
  // this hook is called, if the enabled property was switched.
  // in that case we normaly have to redraw the control.
  if csRedrawEnabledChanged in FExControlStyle then
    InternalRedraw;
end;

procedure TDXPCustomControl.HookFocusedChanged;
begin
  // this hook is called, if the currently focused control was changed.
  if Focused then
    Include( FDrawState, dsFocused )
  else
  begin
    Exclude( FDrawState, dsFocused );
    Exclude( FDrawState, dsClicked );
  end;
  //
  FIsSibling := GetParentForm( Self ).ActiveControl is TDXPCustomControl;
  //
  if csRedrawFocusedChanged in FExControlStyle then
    InternalRedraw;
end;

procedure TDXPCustomControl.HookMouseEnter;
begin
  // this hook is called, if the user moves (hover) the mouse over the control.
  Include( FDrawState, dsHighlight );
  //
  if csRedrawMouseEnter in FExControlStyle then
    InternalRedraw;
  //
  if Assigned( FOnMouseEnter ) then
    FOnMouseEnter( Self );
end;

procedure TDXPCustomControl.HookMouseLeave;
begin
  // this hook is called, if the user moves the mouse away (unhover) from
  // the control.
  Exclude( FDrawState, dsHighlight );
  //
  if csRedrawMouseLeave in FExControlStyle then
    InternalRedraw;
  //
  if Assigned( FOnMouseLeave ) then
    FOnMouseLeave( Self );
end;

procedure TDXPCustomControl.HookMouseMove(X: Integer = 0; Y: Integer = 0);
begin
  // this hook is called if the user moves the mouse inside the control.
  if csRedrawMouseMove in FExControlStyle then
    InternalRedraw;
end;

procedure TDXPCustomControl.HookMouseDown;
begin
  // this hook is called, if the user presses the left mouse button over the
  // controls.
  if not Focused and CanFocus then
    SetFocus;
  //
  Include( FDrawState, dsClicked );
  //
  if csRedrawMouseDown in FExControlStyle then
    InternalRedraw;
end;

procedure TDXPCustomControl.HookMouseUp;
var
  cPos: TPoint;
  NewControl: TWinControl;
begin
  // this hook is called, if the user releases the left mouse button.
  Exclude( FDrawState, dsClicked );
  //
  if csRedrawMouseUp in FExControlStyle then
    InternalRedraw;
  //
  // does the cursor is over another supported control?
  GetCursorPos( cPos );
  NewControl := FindVCLWindow( cPos );
  //
  if ( NewControl <> nil ) and ( NewControl <> Self ) and
    ( NewControl.InheritsFrom( TDXPCustomControl ) ) then
    TDXPCustomControl( NewControl ).HookMouseEnter;
end;

procedure TDXPCustomControl.HookParentColorChanged;
begin
  // this hook is called if, the parent color was changed.
  if csRedrawParentColorChanged in FExControlStyle then
    InternalRedraw;
end;

procedure TDXPCustomControl.HookParentFontChanged;
begin
  // this hook is called if, the parent font was changed.
  if csRedrawParentFontChanged in FExControlStyle then
    InternalRedraw;
end;

procedure TDXPCustomControl.HookPosChanged;
begin
  // this hook is called, if the window position was changed.
  if csRedrawPosChanged in FExControlStyle then
    InternalRedraw;
end;

procedure TDXPCustomControl.HookResized;
begin
  // this hook is called, if the control was resized.
  if csRedrawResized in FExControlStyle then
    InternalRedraw;
end;

procedure TDXPCustomControl.HookTextChanged;
begin
  // this hook is called, if the caption was changed.
  if csRedrawCaptionChanged in FExControlStyle then
    InternalRedraw;
end;

{ TDXPStyle }

constructor TDXPStyle.Create(AOwner: TComponent);
begin
  inherited Create;
  //
  Parent := TDXPCustomStyleControl( AOwner );
  FTheme := WindowsXP;
  FUseStyleManager := True;
end;

procedure TDXPStyle.SetTheme(Value: TDXPTheme);
begin
  if Value <> FTheme then
  begin
    FTheme := Value;
    Parent.InternalRedraw;
  end;
end;

function TDXPStyle.GetTheme: TDXPTheme;
begin
  Result := FTheme;
  //
  if FUseStyleManager and Assigned( Parent.StyleManager ) then
    Result := Parent.StyleManager.Theme;
end;

procedure TDXPStyle.SetUseStyleManager(Value: Boolean);
begin
  if Value <> FUseStyleManager then
  begin
    FUseStyleManager := Value;
    Parent.InternalRedraw;
  end;
end;

{ TDXPStyleManager }

constructor TDXPStyleManager.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  //
  FControls := TList.Create;
  FTheme := WindowsXP;
end;

destructor TDXPStyleManager.Destroy;
begin
  InvalidateControls;
  FControls.Free;
  //
  inherited Destroy;
end;

procedure TDXPStyleManager.InvalidateControls;
var
  i: Integer;
begin
  for i := 0 to FControls.Count - 1 do
    with TDXPCustomControl( FControls[i] ) do
      InternalRedraw;
end;

procedure TDXPStyleManager.SetTheme(Value: TDXPTheme);
begin
  if Value <> FTheme then
  begin
    FTheme := Value;
    //
    if Assigned( FOnThemeChanged ) then
      FOnThemeChanged( Self );
    //
    InvalidateControls;
  end;
end;

procedure TDXPStyleManager.RegisterControls(const AControls: array of TDXPCustomControl);
var
  i: Integer;
begin
  for i := Low( AControls ) to High( AControls ) do
    if FControls.IndexOf( AControls[i] ) = -1 then
      FControls.Add( AControls[i] );
end;

procedure TDXPStyleManager.UnregisterControls(const AControls: array of TDXPCustomControl);
var
  i: Integer;
begin
  for i := Low( AControls ) to High( AControls ) do
    if FControls.IndexOf( AControls[i] ) <> -1 then
      FControls.Delete( FControls.IndexOf( AControls[i] ) );
end;

{ TDXPCustomStyleControl }

constructor TDXPCustomStyleControl.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  //
  FStyle := TDXPStyle.Create( Self );
  FStyleManager := nil;
end;

destructor TDXPCustomStyleControl.Destroy;
begin
  if FStyleManager <> nil then
    FStyleManager.UnregisterControls( [Self] );
  //
  FStyle.Free;
  inherited Destroy;
end;

procedure TDXPCustomStyleControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if ( AComponent is TDXPStyleManager ) and ( Operation = opRemove ) then
    FStyleManager := nil;
  //
  inherited Notification( AComponent, Operation );
end;

procedure TDXPCustomStyleControl.SetStyleManager(Value: TDXPStyleManager);
begin
  if Value <> FStyleManager then
  begin
    if Value <> nil then
      Value.RegisterControls( [Self] )
    else
      FStyleManager.UnregisterControls( [Self] );
    //
    FStyleManager := Value;
    InternalRedraw;
  end;
end;

end.

