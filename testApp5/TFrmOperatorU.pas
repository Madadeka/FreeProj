unit TFrmOperatorU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildWin, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.ExtCtrls, Vcl.WinXCalendars,
  Vcl.StdCtrls, DBReaderU, Generics.Collections, TfrmAddU;

type
  TFrmOperator = class(TMDIChild)
    procedure FormCreate(Sender: TObject);
    procedure btSearchClick(Sender: TObject); override;
    procedure tBtnAddPersonClick(Sender: TObject);
    procedure tBtnAddExtraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrmOperator }

//метод поиска оператора
procedure TFrmOperator.btSearchClick(Sender: TObject);
var
  pList: TList<TPerson>;
begin
  ClearPersonList();
  if edtSearchText.Text = '' then Exit;
  pList:= PersList;
  if TDBReader.FindPerson(pList, Conn, edtSearchText.Text) <> retOk
    then ShowMessage('ќшибка чтени€ данных');
  //список пуст, значит люди не найдены
  if PersList.Count = 0 then
    begin
      ShowMessage('„еловек с такой фамилией не найден');
      Exit;
    end;
  FillPersonGrid;
end;

procedure TFrmOperator.FormCreate(Sender: TObject);
begin
  inherited;
  //подготовка ј–ћ оператора
  gbCondition.Visible:= false;
  cbSearchFull.Checked:= true;
  cbSearchFull.Enabled:= false;
end;

//отображение окна добавлени€ записей в Ѕƒ
procedure TFrmOperator.tBtnAddExtraClick(Sender: TObject);
var
  form: TfrmAdd;
begin
  inherited;

  form:= TfrmAdd.Create(nil);
  try
    //подготавливаю окно, заполн€ю данные о выбранном человеке
    form.pers:= SelectedPers;
    form.edtLName.Text:= form.pers.lName;
    form.edtLName.Enabled:= false;
    form.edtFName.Text:= form.pers.fName;
    form.edtFName.Enabled:= false;
    form.edtPat.Text:= form.pers.pat;
    form.edtPat.Enabled:= false;
    form.cpBDate.Date:= form.pers.bDate;
    form.cpBDate.Enabled:= false;
    form.btAddPerson.Enabled:= false;
    form.Conn:= Conn;
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;
  //обновл€ю таблицу со списком людей
  ReadPerson;
  FillPersonGrid;
end;

//отображение окна добавлени€ записей в Ѕƒ
procedure TFrmOperator.tBtnAddPersonClick(Sender: TObject);
var
  form: TfrmAdd;
begin
  inherited;
  form:= TfrmAdd.Create(nil);
  try
    //подготавливаю окно
    form.btnAddExtra.Enabled:= false;
    form.Conn:= Conn;
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;
  //обновл€ю таблицу со списком людей
  ReadPerson;
  FillPersonGrid;
end;

end.
