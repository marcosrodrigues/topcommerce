unit ufrmDadosValidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, Mask, Validade,
  DBClient, ComCtrls;

type
  TFrmDadosValidade = class(TFrmDadosBase)
    Label5: TLabel;
    deData: TDateTimePicker;
  private
    { Private declarations }
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    Validade: TValidade;
  end;

var
  FrmDadosValidade: TFrmDadosValidade;

implementation

uses MensagensUtils, TypesUtils;

{$R *.dfm}

{ TFrmDadosBase1 }

procedure TFrmDadosValidade.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([deData]);
end;

procedure TFrmDadosValidade.OnDestroy;
begin
  inherited;

end;

procedure TFrmDadosValidade.OnSave;
var
  cds: TClientDataSet;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsValidades'));
  if (Operacao = opInsert) then
  begin
    try
      cds.Append;
      cds.FieldByName('DATA').AsDateTime := deData.Date;
      cds.Post;
    except
      Erro('Ocorreu algum erro durante a inclusão.');
    end;
  end
  else
  begin
    try
      cds.Edit;
      cds.FieldByName('DATA').AsDateTime := deData.Date;
      cds.Post;
    except
      Erro('Ocorreu algum erro durante a inclusão.');
    end;
  end;
end;

procedure TFrmDadosValidade.OnShow;
begin
  inherited;
  if (Assigned(Validade)) then
  begin
    try
      deData.Date := Validade.Data;
    finally
      Validade.Free;
    end;
  end;
end;

end.
