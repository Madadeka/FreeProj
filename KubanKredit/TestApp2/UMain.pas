unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Xml.XMLDoc,
  ComObj, MSXML, Xml.xmldom, Xml.XMLIntf;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    mmXmlStrings: TMemo;
    lbFormatStrings: TListBox;
    btnParse: TButton;
    Splitter1: TSplitter;
    XMLDocument1: TXMLDocument;
    procedure btnParseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnParseClick(Sender: TObject);
var
  LDocument: IXMLDOMDocument;
  node: IXMLNode;
  i: Integer;
  str: string;
begin
  // исходный XML изменен, в mmXmlStrings модифицированный XML, символ '/' перенесен вначало закрывающего тега!!!
  XMLDocument1.XML := mmXmlStrings.lines;
  XMLDocument1.Active:=true;

  node := XMLDocument1.ChildNodes[1].ChildNodes[0];
  lbFormatStrings.Items.Append(node.NodeName);
  for I := 0 to node.ChildNodes.Count - 1 do
  begin
    str := '';
    str := str + 'id = ' + VarToStr(node.ChildNodes[i].Attributes['id']);
    str := str + ', name = ' + VarToStr(node.ChildNodes[i].ChildNodes[0].NodeValue);
    str := str + ', age = ' + VarToStr(node.ChildNodes[i].ChildNodes[1].NodeValue);
    lbFormatStrings.Items.Append(str);
  end;
end;

initialization
  ReportMemoryLeaksOnShutdown := true;

end.
