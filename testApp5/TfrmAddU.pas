unit TfrmAddU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Phys.PGDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, DBReaderU,
  Vcl.WinXCalendars;

type
  TfrmAdd = class(TForm)
    plAddPerson: TPanel;
    plAddExtra: TPanel;
    btAddPerson: TButton;
    plPersonInfo: TPanel;
    Label1: TLabel;
    edtLName: TEdit;
    Label2: TLabel;
    edtFName: TEdit;
    Label3: TLabel;
    edtPat: TEdit;
    Label4: TLabel;
    plExtraInfo: TPanel;
    btnAddExtra: TButton;
    Label5: TLabel;
    mmExtra: TMemo;
    cpBDate: TCalendarPicker;
    procedure btAddPersonClick(Sender: TObject);
    procedure btnAddExtraClick(Sender: TObject);
  private
    { Private declarations }
    function CheckPersEdt(): Boolean;
    function CheckExtraEdt(): Boolean;
  public
    { Public declarations }
    Conn: TFDConnection;
    pers: TPerson;
  end;

var
  frmAdd: TfrmAdd;

implementation

{$R *.dfm}

procedure TfrmAdd.btAddPersonClick(Sender: TObject);
var
  str: string;
begin
  if CheckPersEdt then
  begin
    pers.fName:= edtFName.Text;
    pers.lName:= edtLName.Text;
    pers.pat:= edtPat.Text;
    pers.bDate:= cpBDate.Date;
  end;
  if TDBReader.WritePerson(pers, conn) <> retOK then
    begin
      ShowMessage('Ошибка записи данных клиента');
      Exit;
    end;
  pers.id:= TDBReader.GetLastID(conn);
  btnAddExtra.Enabled:= true;
  DateTimeToString(str, 'dd.mm.yyyy', pers.bDate);
  str:= 'Запись о ' + pers.lName + ' ' + pers.fName + ' ' + str + ' г.р. успешно добавлена';
  ShowMessage(str);
end;

procedure TfrmAdd.btnAddExtraClick(Sender: TObject);
var
  str: string;
begin
  if not CheckExtraEdt then Exit;

  if TDBReader.WriteExtra(pers, conn, mmExtra.Text) <> retOK then
    begin
      ShowMessage('Ошибка записи данных клиента');
      Exit;
    end;

  DateTimeToString(str, 'dd.mm.yyyy', pers.bDate);
  str:= 'Спревка для ' + pers.lName + ' ' + pers.fName + ' ' + str + ' г.р. успешно добавлена';
  ShowMessage(str);
  mmExtra.Clear;
end;

function TfrmAdd.CheckPersEdt: Boolean;
begin
  result:= true;
  if (edtLName.Text = '') or (edtFName.Text = '') or (edtPat.Text = '') or cpBDate.IsEmpty then
    begin
      ShowMessage('Необходимо заполнить все поля');
      result:= false;
      Exit;
    end;
  if cpBDate.Date > Now then
    begin
      ShowMessage('Введена некорректная дата рождения');
      result:= false;
      Exit;
    end;
end;

function TfrmAdd.CheckExtraEdt: Boolean;
begin
  result:= true;
  if mmExtra.Text = '' then
    begin
      ShowMessage('Введите данные о справке');
      result:= false;
      Exit;
    end;
end;

end.
