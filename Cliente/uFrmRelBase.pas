unit uFrmRelBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBXCommon, DB, DBClient, QuickRpt, QRCtrls, QRPDFFilt;

type
  TFrmRelBase = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    qrlTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    cdsRelatorio: TClientDataSet;
    QRShape1: TQRShape;
    QRPDFFilter: TQRPDFFilter;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    DBXConnection: TDBXConnection;

    procedure OnBeforePrint; virtual; abstract;
  public
    { Public declarations }
  end;

var
  FrmRelBase: TFrmRelBase;

implementation

uses uFrmPrincipal;

{$R *.dfm}

procedure TFrmRelBase.FormCreate(Sender: TObject);
begin
  DBXConnection := FrmPrincipal.ConnServidor.DBXConnection;
end;

procedure TFrmRelBase.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  if not cdsRelatorio.Active then
    OnBeforePrint;
end;

end.
