inherited FrmUsuario: TFrmUsuario
  Caption = 'Cadastro de Usu'#225'rios'
  PixelsPerInch = 96
  TextHeight = 14
  inherited cdsCrud: TClientDataSet
    object cdsCrudLOGIN: TStringField
      DisplayLabel = 'Login'
      FieldName = 'LOGIN'
      Size = 15
    end
    object cdsCrudSENHA: TStringField
      DisplayLabel = 'Senha'
      FieldName = 'SENHA'
      Visible = False
    end
    object cdsCrudULTIMOACESSO: TDateTimeField
      DisplayLabel = #218'ltimo Acesso'
      FieldName = 'ULTIMOACESSO'
      OnGetText = cdsCrudULTIMOACESSOGetText
    end
  end
end
