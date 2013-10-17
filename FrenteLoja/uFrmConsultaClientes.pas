unit uFrmConsultaClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, StdCtrls, ExtCtrls, uClienteDAOClient,
  Cliente, DataUtils, pngimage;

type
  TFrmConsultaClientes = class(TForm)
    pnlParametros: TPanel;
    Label1: TLabel;
    edtConsultar: TEdit;
    grdConsulta: TDBGrid;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    cdsConsultaCODIGO: TStringField;
    cdsConsultaNOME: TStringField;
    cdsConsultaTELEFONE: TStringField;
    Panel1: TPanel;
    Image19: TImage;
    procedure edtConsultarChange(Sender: TObject);
    procedure edtConsultarKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grdConsultaDblClick(Sender: TObject);
    procedure grdConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure Image19Click(Sender: TObject);
  private
    { Private declarations }
    DAOClient: TClienteDAOClient;

    procedure Selecionar;
  public
    { Public declarations }
    Cliente: TCliente;
  end;

var
  FrmConsultaClientes: TFrmConsultaClientes;

implementation

uses uFrmPrincipal;

{$R *.dfm}

{ TForm1 }

procedure TFrmConsultaClientes.edtConsultarChange(Sender: TObject);
begin
  cdsConsulta.Filtered := False;
  cdsConsulta.Filter   := 'UPPER(CODIGO) LIKE ' + QuotedStr('%'+UpperCase(edtConsultar.Text)+'%') + ' OR UPPER(NOME) LIKE ' + QuotedStr('%'+UpperCase(edtConsultar.Text)+'%');
  cdsConsulta.Filtered := True;
end;

procedure TFrmConsultaClientes.edtConsultarKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
    Selecionar;
end;

procedure TFrmConsultaClientes.FormCreate(Sender: TObject);
begin
  DAOClient := TClienteDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
end;

procedure TFrmConsultaClientes.FormDestroy(Sender: TObject);
begin
  DAOClient.Free;
end;

procedure TFrmConsultaClientes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Self.Close;
    VK_DOWN: grdConsulta.SetFocus;
  end;
end;

procedure TFrmConsultaClientes.FormShow(Sender: TObject);
begin
  CopyReaderToClientDataSet(DAOClient.List, cdsConsulta);
end;

procedure TFrmConsultaClientes.grdConsultaDblClick(Sender: TObject);
begin
  Selecionar;
end;

procedure TFrmConsultaClientes.grdConsultaKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
    Selecionar;
end;

procedure TFrmConsultaClientes.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmConsultaClientes.Selecionar;
begin
  Cliente          := TCliente.Create;
  Cliente.Codigo   := cdsConsultaCODIGO.AsString;
  Cliente.Nome     := cdsConsultaNOME.AsString;
  Cliente.Telefone := cdsConsultaTELEFONE.AsString;
  Self.Close;
end;

end.
