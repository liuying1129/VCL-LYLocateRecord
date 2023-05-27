unit UfrmLocateRecord;

interface

uses
  Windows, Messages, SysUtils, Forms,Buttons, DB, ActnList, StdCtrls,
  Classes, Controls, ExtCtrls,inifiles;

type
  TfrmLocateRecord = class(TForm)
    ActionList1: TActionList;
    btnFirst: TBitBtn;
    btnClose: TBitBtn;
    Label1: TLabel;
    cmbField: TComboBox;
    Action_Find: TAction;
    Label2: TLabel;
    edtFieldValue: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtFieldValueChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    bLocated:boolean;//����btnFirstClick������ʹ�ã��൱��һ����̬����
    bFirstSearch:boolean;//�Ƿ��һ�β���
    pDataSet:tDataSet;
  public
    { Public declarations }
  end;

type
  TLYLocateRecord = class(TComponent)
  private
    { Private declarations }
    FDataSource:TDataSource;
    procedure FSetDataSource(value:TDataSource);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor create(aowner:tcomponent);override;
    destructor destroy;override;
    function Execute:boolean;
  published
    { Published declarations }
    property DataSource:TDataSource read FDataSource write FSetDataSource;
  end;

procedure Register;
var
  ffrmLocateRecord: TfrmLocateRecord;

implementation

{$R *.dfm}

procedure Register;
begin
  RegisterComponents('Eagle_Ly', [TLYLocateRecord]);
end;

procedure TfrmLocateRecord.FormShow(Sender: TObject);
var
  iField : integer;
  i:integer;
  TLYLocateRecordIni:Tinifile;
  ifSave:boolean;
begin
  bFirstSearch:=true;
  bLocated:=false;
  
  cmbField.Clear ;

  iField:=pDataSet.FieldCount;

  for i:=1 to iField do
  begin
    cmbField.Items.Add(pDataSet.Fields[i-1].FieldName );
  end ;
  
  cmbField.ItemIndex :=0;
  
  //==========���ر���Ĳ�������==============================================//
  if (csDesigning in ComponentState) then exit;
  
  TLYLocateRecordIni:=tinifile.create('.\TLYLocateRecord.ini');
  ifSave:=TLYLocateRecordIni.ReadBool('interface','ifSave',false);
  if not ifSave then begin TLYLocateRecordIni.Free;exit;end;
  CheckBox1.Checked:=ifSave;

  CheckBox2.Checked:=TLYLocateRecordIni.ReadBool('interface','PartialMatching',false);
  cmbField.ItemIndex:=TLYLocateRecordIni.ReadInteger('interface','cmbField',0);
  edtFieldValue.Text:=TLYLocateRecordIni.ReadString('interface','edtFieldValue','');

  TLYLocateRecordIni.Free;
  //==========================================================================//}
end;

procedure TfrmLocateRecord.btnFirstClick(Sender: TObject);
var
  FieldValue:string;
begin
  if bFirstSearch then begin pDataSet.First;bFirstSearch:=false;end;

  while not pDataSet.Eof do
  begin
    if bLocated then pDataSet.Next;
    FieldValue:=uppercase(trim(pDataSet.FieldByName(cmbField.Text).AsString));
    if CheckBox2.Checked then bLocated:=pos(uppercase(trim(edtFieldValue.Text)),FieldValue)>0
      else bLocated:=FieldValue=uppercase(trim(edtFieldValue.Text));
    if bLocated then break;
    pDataSet.Next;

    if (pDataSet.Eof)and(not bLocated) then
    begin
      MessageBox(handle,'�������,��û����Ҫ���ҵļ�¼!�ٴε�����Ұ�ť,���ӿ�ʼ���ر����!','ϵͳ��ʾ',mb_OK);
      bFirstSearch:=true;
    end;
  end;
end;

procedure TfrmLocateRecord.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmLocateRecord.edtFieldValueChange(Sender: TObject);
begin
  bFirstSearch:=true;
end;

procedure TfrmLocateRecord.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmLocateRecord=self then ffrmLocateRecord:=nil;
end;

{ TLYLocateRecord }

constructor TLYLocateRecord.create(aowner: tcomponent);
begin
  inherited Create(AOwner);;
end;

destructor TLYLocateRecord.destroy;
begin
  inherited Destroy;
end;

function TLYLocateRecord.Execute: boolean;
begin
  if FDataSource=nil then
  begin
    raise Exception.Create('û����������Դ����!');  
    result:=false;
    exit;
  end;

  if not fdatasource.DataSet.Active then
  begin
    raise Exception.Create('���ݼ�û�д�!');
    result:=false;
    exit;
  end;

  if fdatasource.DataSet.RecordCount=0 then
  begin
    raise Exception.Create('���ݼ���¼����Ϊ��,�������!');
    result:=false;
    exit;
  end;

  if ffrmLocateRecord=nil then ffrmLocateRecord:=TfrmLocateRecord.Create(nil);
  ffrmLocateRecord.pDataSet:=fdatasource.DataSet;
  ffrmLocateRecord.Show;
  result:=true;
end;

procedure TLYLocateRecord.FSetDataSource(value:TDataSource);
begin
  if value=fdatasource then exit;
  fdatasource:=value;
end;

procedure TfrmLocateRecord.FormDestroy(Sender: TObject);
var
  TLYLocateRecordIni:Tinifile;
begin
  //==========�����������====================================================//
  if (csDesigning in ComponentState) then exit;
  
  TLYLocateRecordIni:=tinifile.create('.\TLYLocateRecord.ini');
  TLYLocateRecordIni.WriteBool('interface','ifSave',CheckBox1.Checked);
  TLYLocateRecordIni.WriteBool('interface','PartialMatching',CheckBox2.Checked);
  TLYLocateRecordIni.WriteInteger('interface','cmbField',cmbField.ItemIndex);
  TLYLocateRecordIni.WriteString('interface','edtFieldValue',edtFieldValue.Text);

  TLYLocateRecordIni.Free;
  //==========================================================================//
end;

initialization
  ffrmLocateRecord:=nil;

end.
