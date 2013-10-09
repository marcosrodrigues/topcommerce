unit uFrmDadosContaReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, DXPCurrencyEdit, ComCtrls,
  uFramePesquisaCliente, RxCurrEdit, Mask, RxToolEdit, uContaReceberDAOClient, ContaReceber,
  DBClient, Cliente;

type
  TFrmDadosContaReceber = class(TFrmDadosBase)
    Label4: TLabel;
    edtId: TEdit;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    mmObservacoes: TMemo;
    FramePesquisaCliente: TFramePesquisaCliente;
    deVencimento: TDateEdit;
    cedValor: TCurrencyEdit;
  private
    { Private declarations }
    DAOClient: TContaReceberDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    ContaReceber: TContaReceber;
  end;

var
  FrmDadosContaReceber: TFrmDadosContaReceber;

implementation

uses MensagensUtils, TypesUtils;

{$R *.dfm}

{ TFrmDadosContaReceber }

procedure TFrmDadosContaReceber.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([FramePesquisaCliente.edtCodigoCliente, deVencimento, cedValor]);
  ContaReceber := TContaReceber.Create;
  DAOClient  := TContaReceberDAOClient.Create(DBXConnection);
end;

procedure TFrmDadosContaReceber.OnDestroy;
begin
  inherited;
//TODO-  ContaReceber.Free;
  DAOClient.Free;
end;

procedure TFrmDadosContaReceber.OnSave;
var
  cds: TClientDataSet;
  ContaReceberTemp: TContaReceber;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if (Operacao = opInsert) then
  begin
    ContaReceberTemp := TContaReceber.Create;
    ContaReceberTemp.Cliente     := TCliente.Create(FramePesquisaCliente.edtCodigoCliente.Text, FramePesquisaCliente.edtNomeCliente.Text, '');
    ContaReceberTemp.Vencimento  := deVencimento.Date;
    ContaReceberTemp.Valor       := cedValor.Value;
    ContaReceberTemp.Observacoes := mmObservacoes.Text;
    ContaReceberTemp.Baixada     := False;

    if not(DAOClient.Insert(ContaReceberTemp)) then
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('CLIENTE_CODIGO').AsString := FramePesquisaCliente.edtCodigoCliente.Text;
    cds.FieldByName('NOME').AsString           := FramePesquisaCliente.edtNomeCliente.Text;
    cds.FieldByName('VENCIMENTO').AsDateTime   := deVencimento.Date;
    cds.FieldByName('VALOR').AsCurrency        := cedValor.Value;
    cds.FieldByName('OBSERVACOES').AsString    := mmObservacoes.Text;
    cds.FieldByName('BAIXADA').AsBoolean       := False;
    cds.Post;
  end
  else
  begin
    //TODO - Ver memory leaks
    ContaReceberTemp := TContaReceber.Create;
    ContaReceberTemp.Id := StrToInt(edtId.Text);
    ContaReceberTemp.Cliente     := TCliente.Create(FramePesquisaCliente.edtCodigoCliente.Text, FramePesquisaCliente.edtNomeCliente.Text, '');
    ContaReceberTemp.Vencimento  := deVencimento.Date;
    ContaReceberTemp.Valor       := cedValor.Value;
    ContaReceberTemp.Observacoes := mmObservacoes.Text;

    if not(DAOClient.Update(ContaReceberTemp)) then
      Erro('Ocorreu algum erro durante a alteração.');

    cds.Edit;
    cds.FieldByName('CLIENTE_CODIGO').AsString := FramePesquisaCliente.edtCodigoCliente.Text;
    cds.FieldByName('NOME').AsString           := FramePesquisaCliente.edtNomeCliente.Text;
    cds.FieldByName('VENCIMENTO').AsDateTime   := deVencimento.Date;
    cds.FieldByName('VALOR').AsCurrency        := cedValor.Value;
    cds.FieldByName('OBSERVACOES').AsString    := mmObservacoes.Text;
    cds.Post;
  end;
  if (chbContinuarIncluindo.Checked) then
    LimparControles
  else
    Self.Close;
end;

procedure TFrmDadosContaReceber.OnShow;
begin
  inherited;
  if Assigned(ContaReceber) then
  begin
    edtId.Text := IntToStr(ContaReceber.Id);
    if Assigned(ContaReceber.Cliente) then
    begin
      FramePesquisaCliente.edtCodigoCliente.Text := ContaReceber.Cliente.Codigo;
      FramePesquisaCliente.edtNomeCliente.Text   := ContaReceber.Cliente.Nome;
    end;
    deVencimento.Date := ContaReceber.Vencimento;
    cedValor.Value := ContaReceber.Valor;
    mmObservacoes.Text := ContaReceber.Observacoes;
  end;
end;

end.
