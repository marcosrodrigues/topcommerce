unit uFrmMovimentoCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, StdCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, uCaixaDAOClient;

type
  TFrmMovimentoCaixa = class(TFrmCrudBase)
    cdsRelatorioID: TIntegerField;
    cdsRelatorioDATA: TDateTimeField;
    cdsRelatorioFECHADO: TBooleanField;
    cdsRelatorioVALOR_ABERTURA: TCurrencyField;
    cdsCrudORIGEM: TIntegerField;
    cdsCrudVALOR: TCurrencyField;
    cdsCrudOPERACAO: TIntegerField;
    procedure cdsCrudORIGEMGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCrudOPERACAOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    DAOClient: TCaixaDAOClient;
  public
    { Public declarations }
    procedure CreateDAOClient; override;
    procedure DestroyDAOClient; override;
    procedure OnShow; override;
    procedure OnInsert; override;
    procedure OnEdit; override;
    procedure OnDelete; override;
    procedure OnPesquisar; override;
  end;

var
  FrmMovimentoCaixa: TFrmMovimentoCaixa;

implementation

uses DataUtils;

{$R *.dfm}

procedure TFrmMovimentoCaixa.cdsCrudOPERACAOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  case Sender.AsInteger of
    1: Text := 'Entrada';
  end;
end;

procedure TFrmMovimentoCaixa.cdsCrudORIGEMGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  case Sender.AsInteger of
    1: Text := 'Caixa';
  end;
end;

procedure TFrmMovimentoCaixa.CreateDAOClient;
begin
  inherited;
  DAOClient := TCaixaDAOClient.Create(DBXConnection);
end;

procedure TFrmMovimentoCaixa.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmMovimentoCaixa.OnDelete;
begin
  inherited;

end;

procedure TFrmMovimentoCaixa.OnEdit;
begin
  inherited;

end;

procedure TFrmMovimentoCaixa.OnInsert;
begin
  inherited;

end;

procedure TFrmMovimentoCaixa.OnPesquisar;
begin
  inherited;

end;

procedure TFrmMovimentoCaixa.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

end.
