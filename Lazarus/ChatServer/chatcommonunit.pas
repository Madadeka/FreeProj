unit ChatCommonUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
    TMessageID = (
               MSGRerror,
               MSGToForm);

    { TSRVMessage }

    TSRVMessage = class(TObject)
    protected
      Constructor Create(ID: TMessageID);
      Destructor  Destroy; override;
    public       
      FID: TMessageID;
    end;

    { TMSGError }

    TMSGError = class(TSRVMessage)
    public
      FValue: Byte;
      Constructor Create(ID: TMessageID; Value: Byte);
      Destructor  Destroy; override;
    end;         

    { TMSGToMemo }

    TMSGToMemo = class(TSRVMessage)
    public
      FString: String;
      Constructor Create(ID: TMessageID; Str: String);
      Destructor  Destroy; override;
    end;

    { TFlag }

    TFlag = class(TObject)
      Constructor Create();
      Destructor  Destroy; override;
    end;



implementation

{ TFlag }

constructor TFlag.Create();
begin
  inherited Create();
end;

destructor TFlag.Destroy;
begin
  inherited ;
end;

{ TMSGToMemo }

constructor TMSGToMemo.Create(ID: TMessageID; Str: String);
begin    
  inherited Create(ID);
  FString:= Str;
end;

destructor TMSGToMemo.Destroy;
begin
  inherited;
end;

{ TMSGError }

constructor TMSGError.Create(ID: TMessageID; Value: Byte);
begin
  inherited Create(ID);
  FValue:= Value;
end;

destructor TMSGError.Destroy;
begin
  inherited;
end;

{ TSRVMessage }

constructor TSRVMessage.Create(ID: TMessageID);
begin
  inherited Create();
  FID:= ID;
end;

destructor TSRVMessage.Destroy;
begin
  inherited;
end;

end.

