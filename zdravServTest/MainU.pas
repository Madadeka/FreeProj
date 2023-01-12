unit MainU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts, LoggerU,
  Vcl.StdCtrls, FireDAC.Phys.PGDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Generics.Collections, DBReaderU,
  Vcl.Grids, ActiveX, ComObj, Vcl.WinXPickers, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, DateUtils;

const

  str_name = 'Работник';
  str_position = 'Должность';
  str_file_name = 'ForMailing2.xls';
  str_file_dir = 'C:\Temp\';

type
  TForm1 = class(TForm)
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    taConn: TFDConnection;
    pnlEmployee: TPanel;
    sgEmployee: TStringGrid;
    IdSMTP1: TIdSMTP;
    Splitter1: TSplitter;
    pnlOptions: TPanel;
    IdMessage1: TIdMessage;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Memo1: TMemo;
    Button4: TButton;
    TimePicker1: TTimePicker;
    Label6: TLabel;
    Timer1: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Label7: TLabel;
    Memo2: TMemo;
    Button1: TButton;
    Button2: TButton;
    Edit5: TEdit;
    Panel6: TPanel;
    Button3: TButton;
    Edit6: TEdit;
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    QText: String;
    QListName: String;
  public
    { Public declarations }
    procedure refreshEmployee();
    procedure saveToXLS();
    procedure sendMessage();
    procedure refreshAll();
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  TrayIcon1.ShowBalloonHint;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  refreshAll();
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  saveDialog : TSaveDialog;
begin
  saveDialog := TSaveDialog.Create(self);
  saveDialog.Title := 'Сохранить отчет как';
  saveDialog.InitialDir := GetCurrentDir;
  saveDialog.Filter := 'Excel file|*.xls';
  saveDialog.DefaultExt := 'xls';
  saveDialog.FilterIndex := 1;

  // Отображение диалог сохранения файла
  if saveDialog.Execute
  then
    begin
      QListName:= saveDialog.FileName;
      Edit5.Text:= QListName;
      Edit6.Text:= QListName;
      saveToXLS();
    end
  else ShowMessage('Отчет не сохранен');

  saveDialog.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  openDialog : TOpenDialog;
begin
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := GetCurrentDir;
  openDialog.Options := [ofFileMustExist];
  openDialog.Filter := 'Excel file|*.xls';
  openDialog.FilterIndex := 1;

  if openDialog.Execute
  then
    begin
      QListName:= openDialog.FileName;
      Edit6.Text:= QListName;
    end
  else ShowMessage('Файл не выбран');

  openDialog.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  l: TLogger;
begin

  l:= TLogger.Create();
  try
    l.addLogStr('start with' +
                ' host: ' + Edit1.Text + ';' +
                ' port: ' + Edit2.Text + ';' +
                ' user: ' + Edit3.Text + ';' +
                ' password: ' + Edit4.Text + ';'
                );
  finally
    FreeAndNil(l);
  end;
  // // установка SMTP
 IdSMTP1.Host := Edit1.Text;
 IdSMTP1.Port := strToInt(Edit2.Text);
 IdSMTP1.Username := Edit3.Text;
 IdSMTP1.Password := Edit4.Text;

 try
   try
     IdSMTP1.Connect;
   except on E:Exception do
     begin
        l:= TLogger.Create();
        try
          l.addLogStr(e.className + ': ' + e.Message);
        finally
          FreeAndNil(l);
        end;
     end;
   end;
 finally
   if IdSMTP1.Connected
    then IdSMTP1.Disconnect;
 end;

 Timer1.Enabled:= True;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  TrayIcon1.Hint := 'Test app';
  TrayIcon1.AnimateInterval := 200;

  TrayIcon1.BalloonTitle := 'Test app';
  TrayIcon1.BalloonHint :=
    'Двойной клик для того чтобы развернуть приложение';
  TrayIcon1.BalloonFlags := bfInfo;
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;

  ReportMemoryLeaksOnShutdown := True;
end;

procedure TForm1.refreshAll;
var
  eList: TList<TList<String>>;
  item: TList<String>;
  s: String;
//  eItem: TTableItem;
  i, j: Integer;
  dReader: TDBReader;
  l: TLogger;
  sqlStr: String;
begin

  sqlStr:= Memo2.Text;
  eList:= TList<TList<String>>.Create();
  try
    dReader:= TDBReader.Create();
    try
      dReader.ReadAll(eList, sqlStr, taConn);

      sgEmployee.ColCount:= eList.Items[0].Count;
      sgEmployee.RowCount:= 0;
      i:= 0;
      for item in eList do
        begin
          j:= 0;
          for s in item do
            begin
              sgEmployee.Cells[j, i]:= s;
              inc(j);
            end;
          inc(i);
          sgEmployee.RowCount:= sgEmployee.RowCount + 1;
        end;


    finally
      FreeAndNil(dReader);
    end;
  finally
    for item in eList do
      begin
        FreeAndNil(item);
      end;
    FreeAndNil(eList);
  end;

end;

procedure TForm1.refreshEmployee;
var
  eList: TList<TTableItem>;
  eItem: TTableItem;
  i: Integer;
  dReader: TDBReader;
  l: TLogger;
begin

  sgEmployee.ColCount:= 2;
  sgEmployee.RowCount:= 1;

  sgEmployee.ColWidths[0]:= 150;
  sgEmployee.ColWidths[1]:= 150;

  sgEmployee.Cells[0,0]:= str_name;
  sgEmployee.Cells[1,0]:= str_position;

  eList:= TList<TTableItem>.Create();
  try
    dReader:= TDBReader.Create();
    try
      dReader.ReadEmployees(eList, taConn);
    finally
      FreeAndNil(dReader);
    end;

  if eList.Count > 0 then
    begin
      i:= 1;
      for eItem in eList do
        begin
          sgEmployee.RowCount:= sgEmployee.RowCount + 1;
          sgEmployee.Cells[0,i]:= eItem.name;
          sgEmployee.Cells[1,i]:= eItem.position;
          inc(i);
        end;
    end;

  l:= TLogger.Create();
  try
    l.addLogStr('count of incoming record: ' + intToStr(eList.Count));
  finally
    FreeAndNil(l);
  end;

  finally
    FreeAndNil(eList);
  end;
end;

procedure TForm1.saveToXLS;
var
  xls, wb, Range: OLEVariant;
  arrData: Variant;
  RowCount, ColCount, i, j: Integer;
  l: TLogger;
begin

  if FileExists(QListName) then
    DeleteFile(QListName);

  RowCount := sgEmployee.RowCount;
  ColCount := sgEmployee.ColCount;
  arrData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);

  for i := 1 to RowCount do
    for j := 1 to ColCount do
      arrData[i, j] := sgEmployee.Cells[j-1, i-1];

  xls := CreateOLEObject('Excel.Application');

  wb := xls.Workbooks.Add;
  try
    try
      Range := wb.WorkSheets[1].Range[wb.WorkSheets[1].Cells[1, 1],
                                      wb.WorkSheets[1].Cells[RowCount, ColCount]];

      Range.Value := arrData;

      wb.SaveAs(QListName);

    except
      on e: Exception do
        begin
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
    wb.close;
  end;

  l:= TLogger.Create();
  try
    l.addLogStr('save to: ' + QListName);
  finally
    FreeAndNil(l);
  end;
end;

procedure TForm1.sendMessage;
var
  str: String;
  l: TLogger;
begin
  IdMessage1.From.Name := 'TestApp';
  IdMessage1.Subject := 'TestApp'; // тема
  IdMessage1.From.Address := 'My address'; // адрес отправителя
  for str in Memo1.Lines do
    begin
      if str <> '' then
        IdMessage1.Recipients.EMailAddresses := str + ',' + str; // получатель + копия
    end;
  IdMessage1.Body.Text := 'File inside...';

  if FileExists(str_file_dir + str_file_name) then
      IdMessage1.AttachmentTempDirectory:= str_file_dir + str_file_name;

  try
    try
      IdSMTP1.Connect();
      Application.ProcessMessages;
      IdSMTP1.Send(IdMessage1);
      l:= TLogger.Create();
      try
        l.addLogStr('all ok');
      finally
        FreeAndNil(l);
      end;
    except on E:Exception do
      begin
        l:= TLogger.Create();
        try
          l.addLogStr(e.ClassName + '; ' + e.Message);
        finally
          FreeAndNil(l);
        end;
      end;
    end;
  finally
    if IdSMTP1.Connected then IdSMTP1.Disconnect;
  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  t, ot: TTime;
  l: TLogger;
begin
  t:= TimePicker1.Time;
  ot:= Time;
  if (HourOf(t) = HourOf(ot)) and (MinuteOf(t) = MinuteOf(ot)) then
    begin
      //TODO: делаю рассылку если есть файл

      l:= TLogger.Create();
      try
        l.addLogStr('try to send message');
      finally
        FreeAndNil(l);
      end;

      //
      if FileExists(QListName) then
        begin
          if Memo1.Lines.Count > 0 then
            //шлю сообщение
            sendMessage();
        end
      else
        begin
          l:= TLogger.Create();
          try
            l.addLogStr('file not found, sending emails canceled');
          finally
            FreeAndNil(l);
          end;
          Timer1.Enabled:= False;
          ShowMessage('file not found, sending emails canceled');
        end;

    end;
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
