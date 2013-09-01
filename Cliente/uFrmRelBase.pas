unit uFrmRelBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBXCommon, DB, DBClient, QuickRpt, QRCtrls, QRPDFFilt,
  RLReport, RLFilters, RLPDFFilter, pngimage;

type
  TFrmRelBase = class(TForm)
    cdsRelatorio: TClientDataSet;
    QRPDFFilter: TQRPDFFilter;
    RLReport: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel2: TRLLabel;
    dsRelatorio: TDataSource;
    RLPDFFilter: TRLPDFFilter;
    RLLabel6: TRLLabel;
    RLImage1: TRLImage;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RLReportBeforePrint(Sender: TObject; var PrintIt: Boolean);
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

procedure TFrmRelBase.RLReportBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  if not cdsRelatorio.Active then
    OnBeforePrint;
end;

end.

