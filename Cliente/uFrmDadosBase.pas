unit uFrmDadosBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmBase, Buttons, ExtCtrls, StdCtrls, TypesUtils, DBXCommon, Spin,
  RxCurrEdit, RxToolEdit;

type
  TFrmDadosBase = class(TFrmBase)
    pnlBotoes: TPanel;
    sbtSalvar: TSpeedButton;
    sbtCancelar: TSpeedButton;
    chbContinuarIncluindo: TCheckBox;
    pnlDados: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbtSalvarClick(Sender: TObject);
    procedure sbtCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FecharSemPerguntar: Boolean;

    procedure SetFirstEditOf(Control: TWinControl);
    //function NextControl(Control: TWinControl): TWinControl;
    //function GetControlOrderList(aParent: TWinControl; aList: TList): integer;
    //function GetTabOrderOf(aControl: TControl): integer;
    //function IsFocusable(aControl: TWinControl): boolean;
  protected
    DBXConnection: TDBXConnection;
    CamposObrigatorios: array of TWinControl;

    procedure OnCreate; virtual; abstract;
    procedure OnDestroy; virtual; abstract;
    procedure OnSave; virtual; abstract;
    procedure OnShow; virtual; abstract;

    procedure LimparControles;
    function ValidaCampos: Boolean;
    procedure SetCamposObrigatorios(co: array of TWinControl);
  public
    { Public declarations }
    Operacao: TOperacao;
  end;

var
  FrmDadosBase: TFrmDadosBase;

implementation

uses uFrmPrincipal, MensagensUtils;

{$R *.dfm}

procedure TFrmDadosBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if not(FecharSemPerguntar) then
  begin
    if (Operacao = opInsert) then
      CanClose := Confirma('Deseja cancelar a inclusão do registro?')
    else
      CanClose := Confirma('Deseja cancelar a edição do registro?');
  end
  else
    CanClose := True;
end;

procedure TFrmDadosBase.FormCreate(Sender: TObject);
begin
  DBXConnection := FrmPrincipal.ConnServidor.DBXConnection;
  OnCreate;
end;

procedure TFrmDadosBase.FormDestroy(Sender: TObject);
begin
  OnDestroy;
end;

procedure TFrmDadosBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F5: sbtSalvar.Click;
    VK_ESCAPE: FecharSemPerguntar := False;
  end;
end;

procedure TFrmDadosBase.FormKeyPress(Sender: TObject; var Key: Char);
//var
  //next: TWinControl;
begin
  inherited;
  {if (Ord(Key) = 13) then
  begin
    next := NextControl(ActiveControl);
    if next <> nil then
      next.SetFocus;
  end;}
end;

procedure TFrmDadosBase.FormShow(Sender: TObject);
begin
  if (Operacao = opInsert) then
    Self.Caption := 'Adicionar Novo Registro'
  else
  begin
    Self.Caption := 'Editar registro';
    chbContinuarIncluindo.Hide;
  end;

  SetFirstEditOf(pnlDados);

  OnShow;
end;

procedure TFrmDadosBase.SetCamposObrigatorios(co: array of TWinControl);
var
  i: Integer;
begin
  SetLength(CamposObrigatorios, Length(co));
  for i := 0 to Length(co) - 1 do
    CamposObrigatorios[i] := co[i];
end;

procedure TFrmDadosBase.SetFirstEditOf(Control: TWinControl);
var
  l:TList;
  i:integer;
  c:TWinControl;
begin
  l:=TList.Create;
  try
    Control.GetTabOrderList(l);
    for i:=0 to l.Count-1 do
    begin
      c:=TWinControl(l[i]);
      if c.Enabled and c.TabStop and c.CanFocus then
        if (c is TCustomEdit) and TEdit(c).ReadOnly then
        else
        begin
          c.SetFocus;
          Exit;
        end;
    end;
  finally
    l.Free;
  end;
end;

function TFrmDadosBase.ValidaCampos: Boolean;
var
  Campo: TWinControl;
begin
  Result := True;
  for Campo in CamposObrigatorios do
  begin
    if (Campo is TEdit) and ((Campo as TEdit).Text = '') then
    begin
      Atencao('Campo obrigatório.');
      Campo.SetFocus;
      Result := False;
      Break;
    end;
    if (Campo is TDateEdit) and ((Campo as TDateEdit).Date = 0) then
    begin
      Atencao('Campo obrigatório.');
      Campo.SetFocus;
      Result := False;
      Break;
    end;
    if (Campo is TCurrencyEdit) and ((Campo as TCurrencyEdit).Value = 0) then
    begin
      Atencao('Campo obrigatório.');
      Campo.SetFocus;
      Result := False;
      Break;
    end;
  end;
end;

procedure TFrmDadosBase.LimparControles;
var
  i, j: Integer;
begin
  for i := 0 to pnlDados.ControlCount - 1 do
  begin
    if (pnlDados.Controls[i] is TEdit) then
      (pnlDados.Controls[i] as TEdit).Clear;
    if (pnlDados.Controls[i] is TDateEdit) then
      (pnlDados.Controls[i] as TDateEdit).Clear;
    if (pnlDados.Controls[i] is TCurrencyEdit) then
      (pnlDados.Controls[i] as TCurrencyEdit).Clear;
    if (pnlDados.Controls[i] is TMemo) then
      (pnlDados.Controls[i] as TMemo).Clear;
    if (pnlDados.Controls[i] is TSpinEdit) then
      (pnlDados.Controls[i] as TSpinEdit).Value := (pnlDados.Controls[i] as TSpinEdit).MinValue;

    if (pnlDados.Controls[i] is TFrame) then
    begin
      for j := 0 to (pnlDados.Controls[i] as TFrame).ControlCount - 1 do
      begin
        if ((pnlDados.Controls[i] as TFrame).Controls[j] is TEdit) then
          ((pnlDados.Controls[i] as TFrame).Controls[j] as TEdit).Clear;
      end;
    end;
  end;
  SetFirstEditOf(pnlDados);
end;

{function TFrmDadosBase.GetTabOrderOf(aControl:TControl):integer;
begin
  Result:=TWinControl(aControl).TabOrder;
end;

function TFrmDadosBase.GetControlOrderList(aParent:TWinControl; aList:TList):integer;
var
  i,j,o:integer;
begin
  aList.Clear;
  for i:=0 to aParent.ControlCount-1 do
    if aParent.Controls[i] is TWinControl then
    begin
      o:=GetTabOrderOf(aParent.Controls[i]);
      if o<>-1 then
      begin
        j:=0;
        while (j<aList.Count) and (GetTabOrderOf(TControl(aList[j]))<=o) do
          Inc(j);
        if j<aList.Count then
          aList.Insert(j,aParent.Controls[i])
        else
          aList.Add(aParent.Controls[i]);
      end;
    end;
  Result:=aList.Count;
end;

function TFrmDadosBase.IsFocusable(aControl:TWinControl):boolean;
begin
  if not aControl.Enabled then
    Result:=False
  else if not aControl.Visible then
    Result:=False
  else if aControl is TRadioButton then
    Result:=TRadioButton(aControl).Checked
  else if aControl is TPage then
    Result:=True
  else if aControl.Name='' then
    Result:=False
  else
    Result:=True;
end;

function TFrmDadosBase.NextControl(Control: TWinControl): TWinControl;
var
  p,w:TWinControl;
  i:integer;
  l:TList;
begin
  Result:=nil;
  l:=TList.Create;
  try
    p:=Control.Parent;
    if p=nil then
      Exit;
    GetControlOrderList(p,l);
    if l.Count=0 then
      Exit;
    w:=Control;
    if w=nil then
      i:=-1
    else
      i:=l.IndexOf(w);
    repeat
      Inc(i);
      if (i<0) or (i>l.Count-1) then
      begin
        if (p is TFrame) then
        begin
          SetFirstEditOf(p);
          Result := nil;
        end
        else
          Result:=NextControl(p);
        Break;
      end;
      w:=TWinControl(l.Items[i]);
      if IsFocusable(w) then
        if (w is TFrame) then
        begin
          SetFirstEditOf(w);
          Result := nil;
          Break;
        end
        else if w.TabStop then
        begin
          Result:=w;
        end;
    until Result<>nil;
  finally
    l.Free;
  end;
end;}

procedure TFrmDadosBase.sbtCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
  FecharSemPerguntar := False;
end;

procedure TFrmDadosBase.sbtSalvarClick(Sender: TObject);
begin
  inherited;
  if ValidaCampos then
  begin
    OnSave;
    if (chbContinuarIncluindo.Checked) then
      LimparControles
    else
    begin
      Self.Close;
      FecharSemPerguntar := True;
    end;
  end;
end;

end.
