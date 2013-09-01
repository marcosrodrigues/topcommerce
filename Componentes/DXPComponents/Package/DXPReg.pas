unit DXPReg;

interface

uses
  Classes, DXPEdit, DXPMaskEdit, DXPDateEdit, DXPPanelDegrade, DXPMessageOutPut, DXPSelect,
  DXPButtons, DXPControl, DXPCurrencyEdit;

procedure Register;

implementation

{$R DXPComponents.dcr}

procedure Register;
begin
  { DXP Standard }
  RegisterComponents( 'DXP Standard', [TDXPEdit] );
  RegisterComponents( 'DXP Standard', [TDXPMaskEdit] );
  RegisterComponents( 'DXP Standard', [TDXPDateEdit] );
  RegisterComponents( 'DXP Standard', [TDXPCurrencyEdit] );
  RegisterComponents( 'DXP Standard', [TDXPButton] );
  // RegisterComponents('DXP Standard', [TDXPToolButton]); Register
  //
  { DXP Additional }
  RegisterComponents( 'DXP Additional', [TDXPPanelDegrade] );
  RegisterComponents( 'DXP Additional', [TDXPMessageOutPut] );
  RegisterComponents( 'DXP Additional', [TDXPSelect] );
  // RegisterComponents('DXP Additional', [TDXPStyleManager]); Register
end;

initialization
  ReportMemoryLeaksOnShutdown := true;

end.
