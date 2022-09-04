unit CHILDWIN;

interface

uses Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.StdCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, Vcl.ToolWin,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.WinXCalendars, DBReaderU, FireDAC.Phys.PGDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.VCLUI.Wait, Data.DB, Vcl.Dialogs,
  FireDAC.Comp.Client, Generics.Collections, TfrmAddU, System.SysUtils;

type
  TMDIChild = class(TForm)
    plSearch: TPanel;
    plArmInfo: TPanel;
    plSearchTop: TPanel;
    lbSearch: TLabel;
    edtSearchText: TEdit;
    cbSearchFull: TCheckBox;
    btSearch: TButton;
    gbCondition: TGroupBox;
    plSerchCond: TPanel;
    plSerchTop: TPanel;
    lblCondDateR: TLabel;
    plCondRegDate: TPanel;
    plSerchBDateLbl: TPanel;
    plCondBDate: TPanel;
    Label2: TLabel;
    cpFromRegDate: TCalendarPicker;
    Label3: TLabel;
    cpToRegDate: TCalendarPicker;
    lblBDate: TLabel;
    Label5: TLabel;
    cpFromBDate: TCalendarPicker;
    Label6: TLabel;
    cpToBDate: TCalendarPicker;
    sgExtras: TStringGrid;
    splGrid: TSplitter;
    sgPerson: TStringGrid;
    tbInfo: TToolBar;
    ImageList1: TImageList;
    tBtnAddPerson: TToolButton;
    tBtnAddExtra: TToolButton;
    ToolButton3: TToolButton;
    tBtnRefresh: TToolButton;
    tBtnSearch: TToolButton;
    tmrRefreshData: TTimer;
    Panel1: TPanel;
    rbLName: TRadioButton;
    rbBDate: TRadioButton;
    rbRegDate: TRadioButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btBtnSearchClick(Sender: TObject);
    procedure sgPersonSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure tBtnRefreshClick(Sender: TObject);
    procedure tmrRefreshDataTimer(Sender: TObject);
    procedure edtSearchTextKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btSearchClick(Sender: TObject);  virtual;
  private
    { Private declarations }
    FConn: TFDConnection;
    FPersList: TList<TPerson>;
    FSelectedPers: TPerson;
    procedure SetConnection(value: TFDConnection);
    procedure SetPersList(value: TList<TPerson>);
    procedure SetPers(value: TPerson);
  public
    { Public declarations }
    procedure FillExtraGrid();
    procedure FillPersonGrid();
    procedure ClearPersonList();
    procedure ReadPerson();
    procedure ColumnWidthAlign(aSg: TStringGrid; aColNum : integer; aDefaultColWidth : Integer = -1);
    property Conn: TFDConnection read FConn write SetConnection;
    property PersList: TList<TPerson> read FPersList write SetPersList;
    property SelectedPers: TPerson read FSelectedPers write SetPers;
  end;

implementation

{$R *.dfm}

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ClearPersonList();
  FreeAndNil(PersList);
  Action := caFree;
end;

procedure TMDIChild.FormCreate(Sender: TObject);
begin
  plSearch.Visible:= false;
  PersList:= TList<TPerson>.Create;
  FillExtraGrid();
end;

procedure TMDIChild.SetConnection(value: TFDConnection);
begin
  FConn:= value;
end;

procedure TMDIChild.SetPers(value: TPerson);
begin
  FSelectedPers:= value;
end;

procedure TMDIChild.SetPersList(value: TList<TPerson>);
begin
  FPersList:= value;
end;

//выбор чеговека в таблице
procedure TMDIChild.sgPersonSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  i, j, k: integer;
  extra: TExtras;
  pers: TPerson;
begin
  inherited;

  FillExtraGrid();
  if sgPerson.Cells[5,ARow] = '' then exit;

  i:= strToInt(sgPerson.Cells[5,ARow]);
  for k:= 1 to sgExtras.RowCount - 1 do
    sgExtras.Rows[i].Clear;
  sgExtras.RowCount:= 1;
  for pers in PersList do
    begin
      if pers.id = i then
        begin
          j:= 1;
          SelectedPers:= pers;
          for extra in pers.extra do
            begin
              sgExtras.RowCount:= sgExtras.RowCount + 1;
              sgExtras.Cells[0,j]:= intToStr(extra.id);
              sgExtras.Cells[1,j]:= extra.extras;
              inc(j);
            end;
          break;
        end;
    end;
  ColumnWidthAlign(sgExtras, 1, 64);

end;

//подгоняю размер ячейки под содержимое
procedure TMDIChild.ColumnWidthAlign(aSg: TStringGrid; aColNum : integer; aDefaultColWidth : Integer = -1);
var
  RowNum       : Integer;
  ColWidth     : Integer;
  MaxColWidth  : Integer;
begin
  if aDefaultColWidth < 0 then
    MaxColWidth := aSg.DefaultColWidth
  else
    MaxColWidth := aDefaultColWidth;
  for RowNum := 0 to Pred(aSg.RowCount) do begin
    ColWidth := aSg.Canvas.TextWidth(aSg.Cells[aColNum, RowNum]);
    if MaxColWidth < ColWidth then MaxColWidth := ColWidth;
  end;
  aSg.ColWidths[aColNum] := MaxColWidth + 20;
end;

//поиск по нажатию на Enter
procedure TMDIChild.edtSearchTextKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    btSearchClick(Sender);
end;

//обновить таблицу с людьми
procedure TMDIChild.tBtnRefreshClick(Sender: TObject);
begin
  ReadPerson;
  FillPersonGrid;
end;

//скрыть/показать поиск
procedure TMDIChild.btBtnSearchClick(Sender: TObject);
begin
  plSearch.Visible:= not plSearch.Visible;
end;

procedure TMDIChild.tmrRefreshDataTimer(Sender: TObject);
begin
  inherited;
  ReadPerson;
  FillPersonGrid;
  tmrRefreshData.Enabled:= false;
end;

//подготовить таблицу со справками
procedure TMDIChild.FillExtraGrid;
begin

  sgExtras.RowCount:= 2;
  sgExtras.ColCount:= 2;

  sgExtras.Cells[0,0]:= 'ID Справки';
  sgExtras.ColWidths[0]:= 70;
  sgExtras.Cells[1,0]:= 'Справка';
  sgExtras.ColWidths[1]:= 70;


  sgExtras.FixedCols:= 0;
  sgExtras.FixedRows:= 1;
end;

//заполняю таблицу с людьми
procedure TMDIChild.FillPersonGrid;
var
  i, k: integer;
  str: string;
  item: TPerson;
begin

  for k:= 1 to sgPerson.RowCount - 1 do
    sgPerson.Rows[k].Clear;

  sgPerson.RowCount:= 1;
  sgPerson.ColCount:= 6;

  sgPerson.Cells[0,0]:= 'Фамилия';
  sgPerson.ColWidths[0]:= 100;
  sgPerson.Cells[1,0]:= 'Имя';
  sgPerson.ColWidths[1]:= 100;
  sgPerson.Cells[2,0]:= 'Отчество';
  sgPerson.ColWidths[2]:= 100;
  sgPerson.Cells[3,0]:= 'Дата рождения';
  sgPerson.ColWidths[3]:= 120;
  sgPerson.Cells[4,0]:= 'Дата регистрации';
  sgPerson.ColWidths[4]:= 120;
  sgPerson.Cells[5,0]:= 'Идентификатор';
  sgPerson.ColWidths[5]:= 70;

  i:= 1;
  with sgPerson do
    begin
      for item in PersList do
        begin
          sgPerson.RowCount:= sgPerson.RowCount + 1;
          Cells[0,i]:= item.lName;
          Cells[1,i]:= item.fName;
          Cells[2,i]:= item.pat;
          DateTimeToString(str, 'dd.mm.yyyy', item.bDate);
          Cells[3,i]:= str;
          DateTimeToString(str, 'dd.mm.yyyy', item.wDate);
          Cells[4,i]:= str;
          Cells[5,i]:= intToStr(item.id);
          inc(i);
        end;
    end;

  sgPerson.FixedCols:= 0;
  sgPerson.FixedRows:= 1;

end;

//поиск по кнопке
procedure TMDIChild.btSearchClick(Sender: TObject);
begin
  //у каждого арм свой поиск
end;

//очищаю список людей
procedure TMDIChild.ClearPersonList;
var
  i: integer;
begin
  if PersList.Count > 0 then
    begin
      for I := 0 to PersList.Count - 1 do FreeAndNil(PersList.Items[i].extra);
    end;
  PersList.Clear;
end;

//получение списка людей
procedure TMDIChild.ReadPerson;
var
  pList: TList<TPerson>;
begin
  ClearPersonList();
  PersList.Clear;
  pList:= PersList;
  if TDBReader.ReadAllPersen(pList, Conn) <> retOk
    then ShowMessage('Ошибка чтения данных');
end;

end.
