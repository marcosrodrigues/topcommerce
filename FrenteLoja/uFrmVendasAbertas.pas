unit uFrmVendasAbertas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, uPedidoVendaDAOClient;

type
  TFrmVendasAbertas = class(TForm)
    grdConsulta: TDBGrid;
    cdsConsulta: TClientDataSet;
    cdsConsultaDATA: TDateTimeField;
    cdsConsultaNOME: TStringField;
    cdsConsultaNOME_CLIENTE_AVULSO: TStringField;
    dsConsulta: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    DAOClient: TPedidoVendaDAOClient;
  public
    { Public declarations }
  end;

var
  FrmVendasAbertas: TFrmVendasAbertas;

implementation

uses uFrmPrincipal, DataUtils;

{$R *.dfm}

procedure TFrmVendasAbertas.FormCreate(Sender: TObject);
begin
  DAOClient := TPedidoVendaDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
end;

procedure TFrmVendasAbertas.FormDestroy(Sender: TObject);
begin
  DAOClient.Free;
end;

procedure TFrmVendasAbertas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Self.Close;
  end;
end;

procedure TFrmVendasAbertas.FormShow(Sender: TObject);
begin
  CopyReaderToClientDataSet(DAOClient.VendasAbertas, cdsConsulta);
end;

end.
