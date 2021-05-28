unit BaseThreadUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  ChatCommonUnit;

type

 { TWorkThreadBase }

 TWorkThreadBase = class(TThread)
  private  
    FWorkObjectID: Byte; // свой собственный идентификатор
  protected
    // конструктор
    // принимает указатель на родителя и id
    Constructor Create(ID: Byte);
    Destructor Destroy; override;
  public
    procedure Send(msg: TSRVMessage); virtual;
    procedure Receive(msg: TSRVMessage); virtual; abstract; // у каждого рабочего свой метод
 end;

implementation

{ TWorkThreadBase }

constructor TWorkThreadBase.Create(ID: Byte);
begin
  inherited Create(True);
  FWorkObjectID:= ID;
end;

destructor TWorkThreadBase.Destroy;
begin
  inherited;
end;

procedure TWorkThreadBase.Send(msg: TSRVMessage);
begin
  //
end;

end.

