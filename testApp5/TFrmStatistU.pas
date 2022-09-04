unit TFrmStatistU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildWin, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.ExtCtrls, Vcl.WinXCalendars,
  Vcl.StdCtrls, DBReaderU, Generics.Collections;

type
  TFrmStatist = class(TMDIChild)
    procedure btSearchClick(Sender: TObject); override;
    procedure rbLNameClick(Sender: TObject);
    procedure rbRegDateClick(Sender: TObject);
    procedure rbBDateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmStatist: TFrmStatist;

implementation

{$R *.dfm}

{ TFrmStatist }

//метод поиска статиста
procedure TFrmStatist.btSearchClick(Sender: TObject);
var
  pList: TList<TPerson>;
begin

  ClearPersonList();
  //поиск по имени
  if rbLName.Checked then
    begin
      pList:= PersList;
      if TDBReader.FindPerson(pList, Conn, edtSearchText.Text) <> retOk
        then ShowMessage('Ошибка чтения данных');
      if PersList.Count = 0 then
        begin
          ShowMessage('Человек с такой фамилией не найден');
          Exit;
        end;
      //обновляю таблицу со списком людей
      FillPersonGrid;
      exit;
    end;

  //поиск по дате рождения
  if rbBDate.Checked then
    begin
      //проверка корректности дат
      if cpFromBDate.Date > cpToBDate.Date then
        begin
          ShowMessage('Даты введены некорректно');
          Exit;
        end;

      pList:= PersList;
      //если ошибка, оповестим пользователя
      if TDBReader.FindPersonByBDate(pList, Conn, cpFromBDate.Date, cpToBDate.Date) <> retOk
        then ShowMessage('Ошибка чтения данных');
      if PersList.Count = 0 then
        begin
          ShowMessage('Человек с такой датой рождения не найден');
          Exit;
        end;
      //обновляю таблицу со списком людей
      FillPersonGrid;
      exit;
    end;

  //поиск по дате регистрации
  if rbRegDate.Checked then
    begin
      //проверка корректности дат
      if cpFromRegDate.Date > cpToRegDate.Date then
        begin
          ShowMessage('Даты введены некорректно');
          Exit;
        end;

      pList:= PersList;
      //если ошибка, оповестим пользователя
      if TDBReader.FindPersonByRegDate(pList, Conn, cpFromRegDate.Date, cpToRegDate.Date) <> retOk
        then ShowMessage('Ошибка чтения данных');
      if PersList.Count = 0 then
        begin
          ShowMessage('Человек с такой датой регистрации не найден');
          Exit;
        end;
      //обновляю таблицу со списком людей
      FillPersonGrid;
      exit;
    end;

end;

procedure TFrmStatist.rbBDateClick(Sender: TObject);
begin
  inherited;
  //делаю неактивными ненужные поля
  edtSearchText.Enabled:= false;
  cpFromRegDate.Enabled:= false;
  cpToRegDate.Enabled:= false;
  cpFromBDate.Enabled:= true;
  cpToBDate.Enabled:= true;

end;

procedure TFrmStatist.rbLNameClick(Sender: TObject);
begin
  inherited;
  //делаю неактивными ненужные поля
  edtSearchText.Enabled:= true;
  cpFromRegDate.Enabled:= false;
  cpToRegDate.Enabled:= false;
  cpFromBDate.Enabled:= false;
  cpToBDate.Enabled:= false;
end;

procedure TFrmStatist.rbRegDateClick(Sender: TObject);
begin
  inherited;
  //делаю неактивными ненужные поля
  edtSearchText.Enabled:= false;
  cpFromRegDate.Enabled:= true;
  cpToRegDate.Enabled:= true;
  cpFromBDate.Enabled:= false;
  cpToBDate.Enabled:= false;

end;

end.
