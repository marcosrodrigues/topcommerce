unit uFrmDadosContaPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, uContaPagarDAOClient, ContaPagar,
  DBClient, uFramePesquisaFornecedor, DXPCurrencyEdit, ComCtrls, Fornecedor,
  Mask, RxToolEdit, RxCurrEdit;

type
  TFrmDadosContaPagar = class(TFrmDadosBase)
    FramePesquisaFornecedor: TFramePesquisaFornecedor;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    mmObservacoes: TMemo;
    Label4: TLabel;
    edtId: TEdit;
    deVencimento: TDateEdit;
    cedValor: TCurrencyEdit;
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
  ContaPagarTemp: TContaPagar;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if (Operacao = opInsert) then
  begin
    ContaPagarTemp := TContaPagar.Create;
    ContaPagarTemp.Fornecedor := TFornecedor.Create(FramePesquisaFornecedor.edtCodigoFornecedor.Text, FramePesquisaFornecedor.edtNomeFornecedor.Text, '');
    ContaPagarTemp.Vencimento  := deVencimento.Date;
    ContaPagarTemp.Valor       := cedValor.Value;
    ContaPagarTemp.Observacoes := mmObservacoes.Text;
    ContaPagarTemp.Baixada     := False;

    if not(DAOClient.Insert(ContaPagarTemp)) then
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('FORNECEDOR_CODIGO').AsString := FramePesquisaFornecedor.edtCodigoFornecedor.Text;
    cds.FieldByName('NOME').AsString              := FramePesquisaFornecedor.edtNomeFornecedor.Text;
    cds.FieldByName('VENCIMENTO').AsDateTime      := deVencimento.Date;
    cds.FieldByName('VALOR').AsCurrency           := cedValor.Value;
    cds.FieldByName('OBSERVACOES').AsString       := mmObservacoes.Text;
    cds.FieldByName('BAIXADA').AsBoolean          := False;
    cds.Post;
  end
  else
  begin
    //TODO - Ver memory leaks
    ContaPagarTemp := TContaPagar.Create;
    ContaPagarTemp.Id := StrToInt(edtId.Text);
    ContaPagarTemp.Fornecedor := TFornecedor.Create(FramePesquisaFornecedor.edtCodigoFornecedor.Text, FramePesquisaFornecedor.edtNomeFornecedor.Text, '');
    ContaPagarTemp.Vencimento  := deVencimento.Date;
    ContaPagarTemp.Valor       := cedValor.Value;
    ContaPagarTemp.Observacoes := mmObservacoes.Text;

    if not(DAOClient.Update(ContaPagarTemp)) then
      Erro('Ocorreu algum erro durante a alteração.');

    cds.Edit;
    cds.FieldByName('FORNECEDOR_CODIGO').AsString := FramePesquisaFornecedor.edtCodigoFornecedor.Text;
    cds.FieldByName('NOME').AsString              := FramePesquisaFornecedor.edtNomeFornecedor.Text;
    cds.FieldByName('VENCIMENTO').AsDateTime      := deVencimento.Date;
    cds.FieldByName('VALOR').AsCurrency           := cedValor.Value;
    cds.FieldByName('OBSERVACOES').AsString       := mmObservacoes.Text;
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
