unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Phys.PGDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    taConn: TFDConnection;
    taQuery: TFDQuery;
    btnGetData: TButton;
    dbgMainData: TDBGrid;
    dsMainData: TDataSource;
    procedure btnGetDataClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnGetDataClick(Sender: TObject);
begin
  taQuery.Close;
  taQuery.SQL.Text := 'select v.store, v.address, v.product, v.price ' +
                 'from view_store_product v';
  taQuery.Open;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  taQuery.Close;
  if taConn.Connected then
    taConn.Close;
end;

initialization
  ReportMemoryLeaksOnShutdown := true;

end.
