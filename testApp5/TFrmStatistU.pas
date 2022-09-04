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

//����� ������ ��������
procedure TFrmStatist.btSearchClick(Sender: TObject);
var
  pList: TList<TPerson>;
begin

  ClearPersonList();
  //����� �� �����
  if rbLName.Checked then
    begin
      pList:= PersList;
      if TDBReader.FindPerson(pList, Conn, edtSearchText.Text) <> retOk
        then ShowMessage('������ ������ ������');
      if PersList.Count = 0 then
        begin
          ShowMessage('������� � ����� �������� �� ������');
          Exit;
        end;
      //�������� ������� �� ������� �����
      FillPersonGrid;
      exit;
    end;

  //����� �� ���� ��������
  if rbBDate.Checked then
    begin
      //�������� ������������ ���
      if cpFromBDate.Date > cpToBDate.Date then
        begin
          ShowMessage('���� ������� �����������');
          Exit;
        end;

      pList:= PersList;
      //���� ������, ��������� ������������
      if TDBReader.FindPersonByBDate(pList, Conn, cpFromBDate.Date, cpToBDate.Date) <> retOk
        then ShowMessage('������ ������ ������');
      if PersList.Count = 0 then
        begin
          ShowMessage('������� � ����� ����� �������� �� ������');
          Exit;
        end;
      //�������� ������� �� ������� �����
      FillPersonGrid;
      exit;
    end;

  //����� �� ���� �����������
  if rbRegDate.Checked then
    begin
      //�������� ������������ ���
      if cpFromRegDate.Date > cpToRegDate.Date then
        begin
          ShowMessage('���� ������� �����������');
          Exit;
        end;

      pList:= PersList;
      //���� ������, ��������� ������������
      if TDBReader.FindPersonByRegDate(pList, Conn, cpFromRegDate.Date, cpToRegDate.Date) <> retOk
        then ShowMessage('������ ������ ������');
      if PersList.Count = 0 then
        begin
          ShowMessage('������� � ����� ����� ����������� �� ������');
          Exit;
        end;
      //�������� ������� �� ������� �����
      FillPersonGrid;
      exit;
    end;

end;

procedure TFrmStatist.rbBDateClick(Sender: TObject);
begin
  inherited;
  //����� ����������� �������� ����
  edtSearchText.Enabled:= false;
  cpFromRegDate.Enabled:= false;
  cpToRegDate.Enabled:= false;
  cpFromBDate.Enabled:= true;
  cpToBDate.Enabled:= true;

end;

procedure TFrmStatist.rbLNameClick(Sender: TObject);
begin
  inherited;
  //����� ����������� �������� ����
  edtSearchText.Enabled:= true;
  cpFromRegDate.Enabled:= false;
  cpToRegDate.Enabled:= false;
  cpFromBDate.Enabled:= false;
  cpToBDate.Enabled:= false;
end;

procedure TFrmStatist.rbRegDateClick(Sender: TObject);
begin
  inherited;
  //����� ����������� �������� ����
  edtSearchText.Enabled:= false;
  cpFromRegDate.Enabled:= true;
  cpToRegDate.Enabled:= true;
  cpFromBDate.Enabled:= false;
  cpToBDate.Enabled:= false;

end;

end.
