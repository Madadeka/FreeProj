unit TBaseServerUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  Winsock,
  BaseThreadUnit,
  SyncObjs,
  ChatCommonUnit;

type

  { TBaseServer }

  TBaseServer = class(TWorkThreadBase)
  private
    //настройки
    FPort: Integer;
    FSRVName: String;
    FClientTimeout    : Integer; //таймаут клиента
    //ConnectionLinit   : Integer; //лимит соединений на поток
    FSocket           : TSocket; //слушающий сокет
    FParent: TObject;
    FServMutex: TCriticalSection;
    procedure Execute(); override;
  public
    IsRunning: Boolean;
    constructor Create(port: integer; Name: string; parent: TObject);
    destructor Destroy(); overload;
    procedure Receive(msg: TSRVMessage); override;
    procedure Send(msg: TSRVMessage); override;
  end;

implementation

uses
  FormUnit;

{ TBaseServer }

procedure TBaseServer.Execute();  
var
  msg: TMSGToMemo;    
  ServerAddr: TSockAddr;
  LSockAddr: TSockAddr;
  arg: Integer;
  clientSocket: TSocket;
  len: Integer;
begin
  //настроил сокет
  ServerAddr.sa_family := AF_Inet;
  ServerAddr.sin_port := htons(FPort);
  ServerAddr.sin_addr.S_addr := INADDR_ANY;
  //настроил адрес   
  FillChar(ServerAddr.sin_zero, SizeOf(ServerAddr.sin_zero), 0);
  FSocket := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  //привязал сокет
  Bind(FSocket, ServerAddr, SizeOf(ServerAddr));
  arg := 1;
  ioctlsocket(FSocket, FIONBIO, arg); //сделал асинхронным  или тут ошибка: всегда принимает соединение      !!!!!!!!
  //поставил сокет на прослушку
  Listen(FSocket, 10000); //SOMAXCONN - система авоматически выставляет очередь, если что
  if not (FSocket > 0) then
    begin
      // TODO: ошибка сокета, отправить на мемо и на выход
      // Exit(); // чтото типа того
    end
  else
    begin
      while IsRunning do
        begin   
          Sleep(1);
          len := SizeOf(LSockAddr);
          clientSocket := 0;
          clientSocket := accept(FSocket, @LSockAddr, len); //тут ошибка: всегда принимает соединение    !!!!!!!
          if clientSocket > 0 then
            begin
              msg:= TMSGToMemo.Create(TMessageID.MSGToForm, 'Got new connevtion, ip = ' + inet_ntoa(LSockAddr.sin_addr) + ' Socket: ' + intToStr(clientSocket));
              (FParent as TForm1).Receive(msg as TSRVMessage);
              FreeAndNil(msg);         
              //TODO: есть подключение, создать объект подключение, создать рабочий поток, объект в поток
            end;


          msg:= TMSGToMemo.Create(TMessageID.MSGToForm, 'serv');
          (FParent as TForm1).Receive(msg as TSRVMessage);
          FreeAndNil(msg);
          sleep(1000);
        end;
    end;

end;

constructor TBaseServer.Create(port: integer; Name: string; parent: TObject);
var
  msg: TMSGToMemo;
begin
  inherited Create(0);
  FPort:= port;
  FSRVName:= Name;
  FParent:= parent;

  msg:= TMSGToMemo.Create(TMessageID.MSGToForm, 'Server is running: ' + FSRVName + ' port: ' + IntToStr(FPort));
  (FParent as TForm1).Receive(msg as TSRVMessage);  
  FreeAndNil(msg);
  FServMutex := TCriticalSection.Create();
end;

destructor TBaseServer.Destroy();
begin
  FServMutex.Free;
  inherited;
end;

procedure TBaseServer.Receive(msg: TSRVMessage);
begin
  FServMutex.Acquire;
  try

  finally
    FServMutex.Release;
  end;
end;

procedure TBaseServer.Send(msg: TSRVMessage);
begin
  case msg.FID of
       TMessageID.MSGToForm:
         begin
           (FParent as TForm1).Receive(msg);
         end;
  end;
end;

end.

