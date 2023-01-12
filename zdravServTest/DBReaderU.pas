unit DBReaderU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Phys.PGDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Generics.Collections, IniFiles, LoggerU;

const

  str_sql_employee = 'SELECT * from employee';

type

  TTableItem = record
    name: String;
    position: String;
  end;

  TDBReader = class(TObject)
  public

    procedure ReadEmployees(list: TList<TTableItem>; conn: TFDConnection);
    procedure ReadAll(var list: TList<TList<String>>; str: String; conn: TFDConnection);

    constructor Create();
    destructor Destroy; override;
  end;

implementation

constructor TDBReader.Create();
var
  iniFile: TIniFile;
begin
  inherited Create();

end;

destructor TDBReader.Destroy;
begin

  inherited;
end;

procedure TDBReader.ReadAll(var list: TList<TList<String>>; str: String; conn: TFDConnection);      //        qGrid.FieldCount
var
  qGrid: TFDQuery;
  sitem: TList<String>;
  l: TLogger;
  i, c: INteger;
  s: String;
  st: TStrings;
begin
  qGrid := TFDQuery.Create(nil);
  try
    qGrid.Connection:= conn;
    qGrid.SQL.Clear;
    qGrid.SQL.Text := str;

    l:= TLogger.Create();
    try
      l.addLogStr('send query: ' + '"' + str + '"');
    finally
      FreeAndNil(l);
    end;

    try
      qGrid.Open;
      try
        c:= qGrid.FieldCount;

        //сохран€ю имена полей
        sitem:= TList<String>.Create();
        for I := 0 to c - 1 do
          begin
            s:= qGrid.Fields.Fields[i].FullName;
            sitem.Add(s);
          end;
        list.Add(sitem);

        //сохран€ю данные
        while not qGrid.EOF do
          begin            //SELECT * from employee
            sitem:= TList<String>.Create();
            for I := 0 to c - 1 do
              begin
                s:= qGrid.Fields.Fields[i].AsString;
                sitem.Add(s);
              end;
            list.Add(sitem);
            qGrid.Next;
          end;
      finally
        qGrid.Close;
      end;
    except
      on e: Exception do
        begin
          qGrid.Connection.Connected:=False;

          l:= TLogger.Create();
          try
            l.addLogStr(e.className + ': ' + e.Message);
          finally
            FreeAndNil(l);
          end;
          //
        end;
    end;
  finally
    FreeAndNil(qGrid);
  end;

end;

procedure TDBReader.ReadEmployees(list: TList<TTableItem>; conn: TFDConnection);
var
  dbItem: TTableItem;
  qGrid: TFDQuery;
  l: TLogger;
begin
  qGrid := TFDQuery.Create(nil);
  try
    qGrid.Connection:= conn;
    qGrid.SQL.Clear;
    qGrid.SQL.Text := str_sql_employee;
    try
      qGrid.Open;
      try
        while not qGrid.EOF do
          begin
            dbItem.name:= qGrid.FieldByName('name').AsString;
            dbItem.position:= qGrid.FieldByName('pposition').AsString;

            list.Add(dbItem);

            qGrid.Next;
          end;
      finally
        qGrid.Close;
      end;
    except
      on e: Exception do
        begin
          qGrid.Connection.Connected:=False;

          l:= TLogger.Create();
          try
            l.addLogStr(e.className + ': ' + e.Message);
          finally
            FreeAndNil(l);
          end;
          //
        end;
    end;
  finally
    FreeAndNil(qGrid);
  end;

end;

end.
