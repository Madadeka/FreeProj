unit DataU;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, LoggerU,
  Generics.Collections;

type

  TStatus = (sRetOk, sRetErr);

  TTestObjectValue = record
    oValue: Variant;
    oDate: TDateTime;
  end;

  TTestObject = record
    oName: string;
    oInfo: string;
    oVal: TArray<TTestObjectValue>;
  end;

  TDataModule1 = class(TDataModule)
    cDBCon: TADOConnection;
    aqTestObjects: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function CreateConnection(const Options: TOptions): TStatus;
    function ReadObjectList(var aList: TList<TTestObject>): TStatus;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

//создание строки подключения к ДБ
function TDataModule1.CreateConnection(const Options: TOptions): TStatus;
begin
  Result := sRetOk;
  DataModule1.cDBCon.LoginPrompt := false;
  DataModule1.cDBCon.ConnectionTimeout := 3;
  DataModule1.cDBCon.ConnectionString := 'Provider=SQLOLEDB.1;' +
    'Password=' + Options.oPass + ';' +
    'Persist Security Info=True;' +
    'User ID=' + Options.oUser + ';' +
    'Initial Catalog=one_base;' +
    'Data Source=' + Options.oServer + ',' + IntToStr(Options.oPort) + ';' +
    'Use Procedure for Prepare=1;' +
    'Auto Translate=True;' +
    'Packet Size=4096;' +
    'Workstation ID=IVANENKOMN;' +
    'Use Encryption for Data=False;' +
    'Tag with column collation when possible=False';

  try
    DataModule1.cDBCon.Connected := true;
  except
    on e:exception do
    begin
      Result := sRetErr;
    end;
  end;
end;

//получение данных TestObject из БД
function TDataModule1.ReadObjectList(var aList: TList<TTestObject>): TStatus;
var
  item: TTestObject;
  tempID: Integer;
begin
  Result := sRetOk;
  if Assigned(aList) then
  begin
    aqTestObjects.Close;
    try
      aqTestObjects.Open;
      try
        //собираю данные
        while not aqTestObjects.EOF do
        begin
          tempID := aqTestObjects.FieldByName('id').AsInteger;
          item.oName:= aqTestObjects.FieldByName('name').AsString;
          item.oInfo:= aqTestObjects.FieldByName('comment').AsString;
          SetLength(item.oVal, 0);
          while (tempID = aqTestObjects.FieldByName('id').AsInteger) and
            (not aqTestObjects.EOF) do
          begin
            SetLength(item.oVal, Length(item.oVal) + 1);
            {obj_id, date_time, value1, value2, value3}
            item.oVal[length(item.oVal) - 1].oValue := aqTestObjects.FieldByName('value1').AsVariant;
            item.oVal[length(item.oVal) - 1].oDate := aqTestObjects.FieldByName('date_time').AsDateTime;
            SetLength(item.oVal, Length(item.oVal) + 1);
            item.oVal[length(item.oVal) - 1].oValue := aqTestObjects.FieldByName('value2').AsVariant;
            item.oVal[length(item.oVal) - 1].oDate := aqTestObjects.FieldByName('date_time').AsDateTime;
            SetLength(item.oVal, Length(item.oVal) + 1);
            item.oVal[length(item.oVal) - 1].oValue := aqTestObjects.FieldByName('value3').AsVariant;
            item.oVal[length(item.oVal) - 1].oDate := aqTestObjects.FieldByName('date_time').AsDateTime;
            aqTestObjects.Next;
          end;
//          if tempID <> aqTestObjects.FieldByName('id').AsInteger then
//          begin
//            Continue;
            aList.Add(item);
//          end;
//          aqTestObjects.Next;
        end;
      finally
        aqTestObjects.Close;
      end;
    except
      on e: Exception do
      begin
        aqTestObjects.Connection.Connected:=False;
        //если чтото пошло не так, вернем sRetErr
        result:= sRetErr;
      end;
    end;
  end
  else
    Result:= sRetErr;
end;

end.
