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

//����� ������ ���������
procedure TFrmOperator.btSearchClick(Sender: TObject);
var
  pList: TList<TPerson>;
begin
  ClearPersonList();
  if edtSearchText.Text = '' then Exit;
  pList:= PersList;
  if TDBReader.FindPerson(pList, Conn, edtSearchText.Text) <> retOk
    then ShowMessage('������ ������ ������');
  //������ ����, ������ ���� �� �������
  if PersList.Count = 0 then
    begin
      ShowMessage('������� � ����� �������� �� ������');
      Exit;
    end;
  FillPersonGrid;
end;

procedure TFrmOperator.FormCreate(Sender: TObject);
begin
  inherited;
  //���������� ��� ���������
  gbCondition.Visible:= false;
  cbSearchFull.Checked:= true;
  cbSearchFull.Enabled:= false;
end;

//����������� ���� ���������� ������� � ��
procedure TFrmOperator.tBtnAddExtraClick(Sender: TObject);
var
  form: TfrmAdd;
begin
  inherited;

  form:= TfrmAdd.Create(nil);
  try
    //������������� ����, �������� ������ � ��������� ��������
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
  //�������� ������� �� ������� �����
  ReadPerson;
  FillPersonGrid;
end;

//����������� ���� ���������� ������� � ��
procedure TFrmOperator.tBtnAddPersonClick(Sender: TObject);
var
  form: TfrmAdd;
begin
  inherited;
  form:= TfrmAdd.Create(nil);
  try
    //������������� ����
    form.btnAddExtra.Enabled:= false;
    form.Conn:= Conn;
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;
  //�������� ������� �� ������� �����
  ReadPerson;
  FillPersonGrid;
end;

end.
