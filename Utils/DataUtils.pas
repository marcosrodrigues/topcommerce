unit DataUtils;

interface

uses
  DBXCommon, DBClient;

procedure CopyReaderToClientDataSet(Reader: TDBXReader; var ClientDataSet: TClientDataSet);

implementation

procedure CopyReaderToClientDataSet(Reader: TDBXReader; var ClientDataSet: TClientDataSet);
var
  i: Integer;
begin
  ClientDataSet.CreateDataSet;
  while Reader.Next do
  begin
    ClientDataSet.Append;
    for i := 0 to Reader.ColumnCount - 1 do
    begin
      case Reader.Value[i].ValueType.DataType of
        TDBXDataTypes.AnsiStringType,
        TDBXDataTypes.BlobType:
          ClientDataSet.Fields[i].AsString := Reader.Value[i].AsString;
        TDBXDataTypes.CurrencyType,
        TDBXDataTypes.DoubleType:
          ClientDataSet.Fields[i].AsCurrency := Reader.Value[i].AsDouble;
        TDBXDataTypes.Int32Type:
          ClientDataSet.Fields[i].AsInteger := Reader.Value[i].AsInt32;
        TDBXDataTypes.DateTimeType,
        TDBXDataTypes.DateType,
        TDBXDataTypes.TimeStampType:
          ClientDataSet.Fields[i].AsDateTime := Reader.Value[i].AsDateTime;
      end;
    end;
    ClientDataSet.Post;
  end;
  ClientDataSet.First;
end;

end.
