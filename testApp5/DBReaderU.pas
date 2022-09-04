unit DBReaderU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Data.DB, FireDAC.Phys.PGDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Generics.Collections;

type

  TRet= (retOK, retErr);

  TExtras = record
    id: integer;
    idPerson: integer;
    extras: string;
  end;

  TPerson = record
    id: integer;
    fName: string;
    lName: String;
    pat: string;
    bDate: TDateTime;
    wDate: TDateTime;
    extra: TList<TExtras>;
  end;



  TDBReader = class(TObject)
  public
    class function ReadAllPersen(var list: TList<TPerson>; conn: TFDConnection): TRet;
    class function WritePerson(pers: TPerson; conn: TFDConnection): TRet;
    class function FindPerson(var list: TList<TPerson>; conn: TFDConnection; pers: string): TRet;
    class function WriteExtra(pers: TPerson; conn: TFDConnection; extra: string): TRet;
    class function GetLastID(conn: TFDConnection): integer;
    class function FindPersonByBDate(var list: TList<TPerson>; conn: TFDConnection;
      fromDate:TDateTime; toDate: TDateTime): TRet;
    class function FindPersonByRegDate(var list: TList<TPerson>; conn: TFDConnection;
      fromDate:TDateTime; toDate: TDateTime): TRet;

    constructor Create();
    destructor Destroy; override;
  end;

implementation

constructor TDBReader.Create();
begin
  inherited Create();

end;

destructor TDBReader.Destroy;
begin

  inherited;
end;

//поиск людей по фамилии, в случае ошибки вернет retErr
class function TDBReader.FindPerson(var list: TList<TPerson>; conn: TFDConnection; pers: string): TRet;
var
  qGrid: TFDQuery;
  item: TPerson;
  i: integer;
  extra: TExtras;
begin
  result:= retOK;
  qGrid := TFDQuery.Create(nil);
  try
    qGrid.Connection:= conn;
    qGrid.SQL.Clear;
    //получаю список людей из Ѕƒ
    qGrid.SQL.Text := 'select * from person where last_name = :lname order by id';
    qGrid.Params.ParamByName('lname').Value := pers;

    try
      qGrid.Open;
      try

        //сохран€ю данные
        while not qGrid.EOF do
          begin
            item.id:= qGrid.FieldByName('id').AsInteger;
            item.fName:= qGrid.FieldByName('first_name').AsString;
            item.lName:= qGrid.FieldByName('last_name').AsString;
            item.pat:= qGrid.FieldByName('pat').AsString;
            item.bDate:= qGrid.FieldByName('birth_date').AsDateTime;
            item.wDate:= qGrid.FieldByName('write_date').AsDateTime;
            item.extra:= TList<TExtras>.Create;

            list.Add(item);

            qGrid.Next;
          end;
      finally
        qGrid.Close;
      end;
    except
      on e: Exception do
        begin
          qGrid.Connection.Connected:=False;
          result:= retErr;
          //
        end;
    end;

    for i := 0 to list.Count - 1 do
      begin
        qGrid.SQL.Clear;
        //получаю справки людей
        qGrid.SQL.Text := 'select * from extras where id_person = :pID  order by id';
        qGrid.Params.ParamByName('pID').Value := list.Items[i].id;
        try
          qGrid.Open;
          try

            //сохран€ю данные
            while not qGrid.EOF do
              begin
                extra.id:= qGrid.FieldByName('id').AsInteger;
                extra.idPerson:= qGrid.FieldByName('id_person').AsInteger;
                extra.extras:= qGrid.FieldByName('ext').AsString;

                list.Items[i].extra.Add(extra);

                qGrid.Next;
              end;
          finally
            qGrid.Close;
          end;
        except
          on e: Exception do
            begin
              qGrid.Connection.Connected:=False;
              result:= retErr;
              //
            end;
        end;

      end;

  finally
    FreeAndNil(qGrid);
  end;

end;

//поиск людей по дате рождени€, в случае ошибки вернет retErr
class function TDBReader.FindPersonByBDate(var list: TList<TPerson>;
  conn: TFDConnection; fromDate, toDate: TDateTime): TRet;
var
  qGrid: TFDQuery;
  item: TPerson;
  i: integer;
  extra: TExtras;
begin
  result:= retOK;
  qGrid := TFDQuery.Create(nil);
  try
    qGrid.Connection:= conn;
    qGrid.SQL.Clear;
    //получаю людей
    qGrid.SQL.Text := 'select * from person ' +
                      'WHERE birth_date BETWEEN SYMMETRIC :fromD AND :toD';

    qGrid.Params.ParamByName('fromD').Value := fromDate;
    qGrid.Params.ParamByName('toD').Value := toDate;

    try
      qGrid.Open;
      try
        while not qGrid.EOF do
          begin
            item.id:= qGrid.FieldByName('id').AsInteger;
            item.fName:= qGrid.FieldByName('first_name').AsString;
            item.lName:= qGrid.FieldByName('last_name').AsString;
            item.pat:= qGrid.FieldByName('pat').AsString;
            item.bDate:= qGrid.FieldByName('birth_date').AsDateTime;
            item.wDate:= qGrid.FieldByName('write_date').AsDateTime;
            item.extra:= TList<TExtras>.Create;

            list.Add(item);

            qGrid.Next;
          end;
      finally
        qGrid.Close;
      end;
    except
      on e: Exception do
        begin
          qGrid.Connection.Connected:=False;
          result:= retErr;
          //
        end;
    end;

    for i := 0 to list.Count - 1 do
      begin
        qGrid.SQL.Clear;
        //получаю справки людей
        qGrid.SQL.Text := 'select * from extras where id_person = :pID  order by id';
        qGrid.Params.ParamByName('pID').Value := list.Items[i].id;
        try
          qGrid.Open;
          try

            //сохран€ю данные
            while not qGrid.EOF do
              begin
                extra.id:= qGrid.FieldByName('id').AsInteger;
                extra.idPerson:= qGrid.FieldByName('id_person').AsInteger;
                extra.extras:= qGrid.FieldByName('ext').AsString;

                list.Items[i].extra.Add(extra);

                qGrid.Next;
              end;
          finally
            qGrid.Close;
          end;
        except
          on e: Exception do
            begin
              qGrid.Connection.Connected:=False;
              result:= retErr;
              //
            end;
        end;

      end;

  finally
    FreeAndNil(qGrid);
  end;
end;

//поиск людей по дате регистрации в базе, в случае ошибки вернет retErr
class function TDBReader.FindPersonByRegDate(var list: TList<TPerson>;
  conn: TFDConnection; fromDate, toDate: TDateTime): TRet;
var
  qGrid: TFDQuery;
  item: TPerson;
  i: integer;
  extra: TExtras;
begin
  result:= retOK;
  qGrid := TFDQuery.Create(nil);
  try
    qGrid.Connection:= conn;
    qGrid.SQL.Clear;
    //список людей
    qGrid.SQL.Text := 'select * from person ' +
                      'WHERE write_date BETWEEN SYMMETRIC :fromD AND :toD';

    qGrid.Params.ParamByName('fromD').Value := fromDate;
    qGrid.Params.ParamByName('toD').Value := toDate;

    try
      qGrid.Open;
      try
        while not qGrid.EOF do
          begin
            item.id:= qGrid.FieldByName('id').AsInteger;
            item.fName:= qGrid.FieldByName('first_name').AsString;
            item.lName:= qGrid.FieldByName('last_name').AsString;
            item.pat:= qGrid.FieldByName('pat').AsString;
            item.bDate:= qGrid.FieldByName('birth_date').AsDateTime;
            item.wDate:= qGrid.FieldByName('write_date').AsDateTime;
            item.extra:= TList<TExtras>.Create;

            list.Add(item);

            qGrid.Next;
          end;
      finally
        qGrid.Close;
      end;
    except
      on e: Exception do
        begin
          qGrid.Connection.Connected:=False;
          result:= retErr;
          //
        end;
    end;

    for i := 0 to list.Count - 1 do
      begin
        qGrid.SQL.Clear;
        //справки людей
        qGrid.SQL.Text := 'select * from extras where id_person = :pID  order by id';
        qGrid.Params.ParamByName('pID').Value := list.Items[i].id;
        try
          qGrid.Open;
          try

            //сохран€ю данные
            while not qGrid.EOF do
              begin
                extra.id:= qGrid.FieldByName('id').AsInteger;
                extra.idPerson:= qGrid.FieldByName('id_person').AsInteger;
                extra.extras:= qGrid.FieldByName('ext').AsString;

                list.Items[i].extra.Add(extra);

                qGrid.Next;
              end;
          finally
            qGrid.Close;
          end;
        except
          on e: Exception do
            begin
              qGrid.Connection.Connected:=False;
              result:= retErr;
              //
            end;
        end;

      end;

  finally
    FreeAndNil(qGrid);
  end;
end;

//получить последний id зарегестрированного
//нужно дл€ добавлени€ справок человеку сразу после регистрации
//вернет -1 вместо ID, если чтото пошло не так
class function TDBReader.GetLastID(conn: TFDConnection): integer;
var
  qGrid: TFDQuery;
begin
  result:= -1;
  qGrid := TFDQuery.Create(nil);
  try
    qGrid.Connection:= conn;
    qGrid.SQL.Clear;
    qGrid.SQL.Text := 'select max(id) id from person';

    try
      qGrid.Open;
      try
        while not qGrid.EOF do
          begin
            result:= qGrid.FieldByName('id').AsInteger;
            qGrid.Next;
          end;
      finally
        qGrid.Close;
      end;
    except
      on e: Exception do
        begin
          qGrid.Connection.Connected:=False;
          result:= -1;
          //
        end;
    end;

  finally
    FreeAndNil(qGrid);
  end;
end;

//получаю 10 последних записей из бд(по тз)
class function TDBReader.ReadAllPersen(var list: TList<TPerson>; conn: TFDConnection): TRet;
var
  qGrid: TFDQuery;
  item: TPerson;
  i: integer;
  extra: TExtras;
begin
  result:= retOK;
  qGrid := TFDQuery.Create(nil);
  try
    qGrid.Connection:= conn;
    qGrid.SQL.Clear;
    qGrid.SQL.Text := 'select * from person order by id desc limit 10';

    try
      qGrid.Open;
      try

        //сохран€ю данные
        while not qGrid.EOF do
          begin
            item.id:= qGrid.FieldByName('id').AsInteger;
            item.fName:= qGrid.FieldByName('first_name').AsString;
            item.lName:= qGrid.FieldByName('last_name').AsString;
            item.pat:= qGrid.FieldByName('pat').AsString;
            item.bDate:= qGrid.FieldByName('birth_date').AsDateTime;
            item.wDate:= qGrid.FieldByName('write_date').AsDateTime;
            item.extra:= TList<TExtras>.Create;

            list.Add(item);

            qGrid.Next;
          end;
      finally
        qGrid.Close;
      end;
    except
      on e: Exception do
        begin
          qGrid.Connection.Connected:=False;
          result:= retErr;
          //
        end;
    end;

    for i := 0 to list.Count - 1 do
      begin
        qGrid.SQL.Clear;
        qGrid.SQL.Text := 'select * from extras where id_person = :pID  order by id';
        qGrid.Params.ParamByName('pID').Value := list.Items[i].id;
        try
          qGrid.Open;
          try

            //сохран€ю данные
            while not qGrid.EOF do
              begin
                extra.id:= qGrid.FieldByName('id').AsInteger;
                extra.idPerson:= qGrid.FieldByName('id_person').AsInteger;
                extra.extras:= qGrid.FieldByName('ext').AsString;

                list.Items[i].extra.Add(extra);

                qGrid.Next;
              end;
          finally
            qGrid.Close;
          end;
        except
          on e: Exception do
            begin
              qGrid.Connection.Connected:=False;
              result:= retErr;
              //
            end;
        end;

      end;

  finally
    FreeAndNil(qGrid);
  end;

end;

//добавить справку человеку в Ѕƒ
class function TDBReader.WriteExtra(pers: TPerson; conn: TFDConnection;
  extra: string): TRet;
var
  qGrid: TFDQuery;
begin
  result:= retOK;
  qGrid := TFDQuery.Create(nil);
  try
    qGrid.Connection:= conn;
    qGrid.SQL.Clear;
    qGrid.SQL.Text := 'insert into extras (id_person, ext) ' +
                      'values(:pID, :extra)';

    qGrid.Params.ParamByName('pID').Value := pers.id;
    qGrid.Params.ParamByName('extra').Value := extra;

    try
      qGrid.ExecSQL;
    except
      on e: Exception do
        begin
          qGrid.Connection.Connected:=False;
          result:= retErr;
          //
        end;
    end;
  finally
    FreeAndNil(qGrid);
  end;

end;

//добавить человека в Ѕƒ
class function TDBReader.WritePerson(pers: TPerson; conn: TFDConnection): TRet;
var
  qGrid: TFDQuery;
begin
  result:= retOK;
  qGrid := TFDQuery.Create(nil);
  try
    qGrid.Connection:= conn;
    qGrid.SQL.Clear;
    qGrid.SQL.Text := 'insert into person (first_name, last_name, pat, birth_date, write_date) ' +
                      'values(:fname, :lname, :pat, :bDate, current_timestamp)';

    qGrid.Params.ParamByName('fname').Value := pers.fName;
    qGrid.Params.ParamByName('lname').Value := pers.lName;
    qGrid.Params.ParamByName('pat').Value := pers.pat;
    qGrid.Params.ParamByName('bDate').Value := pers.bDate;

    try
      qGrid.ExecSQL;
    except
      on e: Exception do
        begin
          qGrid.Connection.Connected:=False;
          result:= retErr;
          //
        end;
    end;
  finally
    FreeAndNil(qGrid);
  end;

end;

end.
