unit uFrmDadosContaPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, uContaPagarDAOClient, ContaPagar,
  DBClient, uFramePesquisaFornecedor, DXPCurrencyEdit, ComCtrls, Fornecedor;

type
  TFrmDadosContaPagar = class(TFrmDadosBase)
    FramePesquisaFornecedor: TFramePesquisaFornecedor;
    deVencimento: TDateTimePicker;
    Label3: TLabel;
    cedValor: TDXPCurrencyEdit;
    Label1: TLabel;
    Label2: TLabel;
    mmObservacoes: TMemo;
    Label4: TLabel;
    edtId: TEdit;
  private
    { Private declarations }
    DAOClient: TContaPagarDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    ContaPagar: TContaPagar;
  end;

var
  FrmDadosContaPagar: TFrmDadosContaPagar;

implementation

uses MensagensUtils, uFornecedorDAOClient, TypesUtils;

{$R *.dfm}

{ TFrmDadosContaPagar }

procedure TFrmDadosContaPagar.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([FramePesquisaFornecedor.edtCodigoFornecedor, deVencimento, cedValor]);
  ContaPagar := TContaPagar.Create;
  DAOClient  := TContaPagarDAOClient.Create(DBXConnection);
end;

procedure TFrmDadosContaPagar.OnDestroy;
begin
  inherited;
//TODO-  ContaPagar.Free;
  DAOClient.Free;
end;

procedure TFrmDadosContaPagar.OnSave;
var
  cds: TClientDataSet;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if (Operacao = opInsert) then
  begin
    ContaPagar.Fornecedor := TFornecedor.Create(FramePesquisaFornecedor.edtCodigoFornecedor.Text, FramePesquisaFornecedor.edtNomeFornecedor.Text, '');
    ContaPagar.Vencimento  := deVencimento.Date;
    ContaPagar.Valor       := cedValor.Value;
    ContaPagar.Observacoes := mmObservacoes.Text;
    ContaPagar.Baixada     := False;

    if not(DAOClient.Insert(ContaPagar)) then
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('FORNECEDOR_CODIGO').AsString := ContaPagar.Fornecedor.Codigo;
    cds.FieldByName('NOME').AsString              := ContaPagar.Fornecedor.Nome;
    cds.FieldByName('VENCIMENTO').AsDateTime      := ContaPagar.Vencimento;
    cds.FieldByName('VALOR').AsCurrency           := ContaPagar.Valor;
    cds.FieldByName('OBSERVACOES').AsString       := ContaPagar.Observacoes;
    cds.FieldByName('BAIXADA').AsBoolean          := ContaPagar.Baixada;
    cds.Post;
  end
  else
  begin
    ContaPagar.Id := StrToInt(edtId.Text);
    ContaPagar.Fornecedor := TFornecedor.Create(FramePesquisaFornecedor.edtCodigoFornecedor.Text, FramePesquisaFornecedor.edtNomeFornecedor.Text, '');
    ContaPagar.Vencimento  := deVencimento.Date;
    ContaPagar.Valor       := cedValor.Value;
    ContaPagar.Observacoes := mmObservacoes.Text;

    if not(DAOClient.Update(ContaPagar)) then
      Erro('Ocorreu algum erro durante a alteração.');

    cds.Edit;
    cds.FieldByName('FORNECEDOR_CODIGO').AsString := ContaPagar.Fornecedor.Codigo;
    cds.FieldByName('NOME').AsString              := ContaPagar.Fornecedor.Nome;
    cds.FieldByName('VENCIMENTO').AsDateTime      := ContaPagar.Vencimento;
    cds.FieldByName('VALOR').AsCurrency           := ContaPagar.Valor;
    cds.FieldByName('OBSERVACOES').AsString       := ContaPagar.Observacoes;
    cds.Post;
  end;
  if (chbContinuarIncluindo.Checked) then
    LimparControles
  else
    Self.Close;
end;

procedure TFrmDadosContaPagar.OnShow;
begin
  inherited;
  if Assigned(ContaPagar) then
  begin
    edtId.Text := IntToStr(ContaPagar.Id);
    if Assigned(ContaPagar.Fornecedor) then
    begin
      FramePesquisaFornecedor.edtCodigoFornecedor.Text := ContaPagar.Fornecedor.Codigo;
      FramePesquisaFornecedor.edtNomeFornecedor.Text := ContaPagar.Fornecedor.Nome;
    end;
    deVencimento.Date := ContaPagar.Vencimento;
    cedValor.Value := ContaPagar.Valor;
    mmObservacoes.Text := ContaPagar.Observacoes;
  end;
end;

end.
