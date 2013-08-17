unit uFrmDadosMasterDetailBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFrmDadosMasterDetailBase = class(TFrmDadosBase)
    pnlDetails: TPanel;
    splDados: TSplitter;
    pgcDetail: TPageControl;
    pnlBotoesDetails: TPanel;
    sbtNovo: TSpeedButton;
    sbtEditar: TSpeedButton;
    sbtExcluir: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  protected
    procedure OnShow; override;
  public
    { Public declarations }
  end;

var
  FrmDadosMasterDetailBase: TFrmDadosMasterDetailBase;

implementation

{$R *.dfm}

procedure TFrmDadosMasterDetailBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F2: sbtNovo.Click;
    VK_F3: sbtEditar.Click;
    VK_F4: sbtExcluir.Click;
  end;
end;

procedure TFrmDadosMasterDetailBase.OnShow;
begin
  inherited;
  pgcDetail.ActivePageIndex := 0;
end;

end.
