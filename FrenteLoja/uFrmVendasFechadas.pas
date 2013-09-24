unit uFrmVendasFechadas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, uPedidoVendaDAOClient;

type
  TFrmVendasFechadas = class(TForm)
    grdConsulta: TDBGrid;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    cdsConsultaDATA: TDateTimeField;
    cdsConsultaNOME: TStringField;
    cdsConsultaNOME_CLIENTE_AVULSO: TStringField;
    cdsConsultaCODIGO: TStringField;
    cdsConsultaTOTAL: TCurrencyField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grdConsultaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    DAOClient: TPedidoVendaDAOClient;
  public
    { Public declarations }
  end;

var
  FrmVendasFechadas: TFrmVendasFechadas;

implementation

uses uFrmPrincipal, DataUtils;

{$R *.dfm}

procedure TFrmVendasFechadas.FormCreate(Sender: TObject);
begin
  DAOClient := TPedidoVendaDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
end;

procedure TFrmVendasFechadas.FormDestroy(Sender: TObject);
begin
  DAOClient.Free;
end;

procedure TFrmVendasFechadas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: begin
                 Self.ModalResult := mrCancel;
                 Self.CloseModal;
               end;
  end;
end;

procedure TFrmVendasFechadas.FormShow(Sender: TObject);
begin
  CopyReaderToClientDataSet(DAOClient.VendasFechadas, cdsConsulta);
end;

procedure TFrmVendasFechadas.grdConsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Ord(Key) = 13 then
  begin
    Self.ModalResult := mrOk;
    Self.CloseModal;
  end;
end;

end.