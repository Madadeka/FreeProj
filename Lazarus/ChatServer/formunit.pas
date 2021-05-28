unit FormUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ChatCommonUnit, TBaseServerUnit, SyncObjs, Winsock;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private             
    WSAData: TWSAData;
    FFormMutex: TCriticalSection;
    FServer: TBaseServer;
    procedure StopServer();
    procedure RunServer();
  public                   
    procedure Receive(msg: TSRVMessage);

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button3Click(Sender: TObject);
begin
  StopServer();
  self.Close();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if WSAStartup($101, WSAData) <> 0 then
    begin
      self.Memo2.Lines.Add('WSAStartup error');    
      self.Button1.Enabled:= not self.Button1.Enabled;
      self.Button2.Enabled:= not self.Button2.Enabled;
    end;
  self.Button2.Enabled:= False;
  FFormMutex:= TCriticalSection.Create();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FFormMutex.Free;
end;

procedure TForm1.StopServer();
begin
  if self.FServer <> nil then
     begin
       if self.FServer.IsRunning <> False then
         begin
           self.FServer.IsRunning:= False;
           sleep(10);
           self.FServer.Terminate;
           self.FServer.Destroy();
           self.FServer:= nil;
           self.Memo2.Lines.Add('Stop');  
           self.Button1.Enabled:= not self.Button1.Enabled;
           self.Button2.Enabled:= not self.Button2.Enabled;
         end;
     end;
end;

procedure TForm1.RunServer();
var
  ret: Boolean;
  tempPort: Integer;
begin
  ret:= TryStrToInt(Edit3.Caption, tempPort);
  if ret and (self.FServer = nil) then
    begin
      self.FServer:= TBaseServer.Create(tempPort, Edit1.Caption, self);
      self.FServer.FreeOnTerminate:= False;
      self.FServer.Priority:= tpNormal;
      self.FServer.IsRunning:= True;
      self.FServer.Start;
      self.Button1.Enabled:= not self.Button1.Enabled;
      self.Button2.Enabled:= not self.Button2.Enabled;
    end
  else
    begin
      self.Memo2.Lines.add('Server error');
    end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  RunServer();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin   
  StopServer();
end;

procedure TForm1.Receive(msg: TSRVMessage);
begin
  FFormMutex.Acquire;
  try
    case msg.FID of
      TMessageID.MSGToForm:
        begin
          self.Memo2.Lines.add('Message:');
          self.Memo2.Lines.add((msg as TMSGToMemo).FString);
        end;
    end;
  finally
    FFormMutex.Release;
  end;

end;

end.

