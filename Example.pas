{******************************************************************************}
{                                                                              }
{ �˺� Ȩ�ý� ���ڼ��ݰ�꼭 ����/���� API Delphi SDK Example                  }
{                                                                              }
{ - ������ SDK ������ �ȳ� : http://blog.linkhub.co.kr/572                   }
{ - ������Ʈ ���� : 2018-09-18                                                 }
{ - ���� ������� ����ó : 1600-9854 / 070-4304-2991                           }
{ - ���� ������� �̸��� : code@linkhub.co.kr                                  }
{                                                                              }
{ <�׽�Ʈ �������� �غ����>                                                   }
{ (1) 38, 41�� ���ο� ����� ��ũ���̵�(LinkID)�� ���Ű(SecretKey)��          }
{    ��ũ��� ���Խ� ���Ϸ� �߱޹��� ���������� ����                           }
{ (2) �˺� ���߿� ����Ʈ(test.popbill.com)�� ����ȸ������ ����                 }
{ (3) Ȩ�ý� ���������� ���, 2���� �������                                   }
{     - �˺�����Ʈ �α��� > [Ȩ�ý�����] > ȭ����� �ϴ��� [ȯ�漳��] >        }
{       [���������� ����]                                                      }
{    - Ȩ�ý� ������������� URL (GetCertificatePopUpURL API)�� �̿��Ͽ� ���  }
{                                                                              }
{******************************************************************************}

unit Example;

interface

uses
Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, TypInfo,
  Popbill, PopbillHTTaxinvoice, ExtCtrls, Grids;
  
const
        {**********************************************************************}
        { - ��������(��ũ���̵�, ���Ű)�� ��Ʈ���� ����ȸ���� �ĺ��ϴ�        }
        {   ������ ���ǹǷ� ������� �ʵ��� �����Ͻñ� �ٶ��ϴ�              }
        { - ����� ��ȯ���Ŀ��� ���������� ������� �ʽ��ϴ�.                  }
        {**********************************************************************}
        
        // ��ũ���̵�.
        LinkID = 'TESTER';
        
        // ��Ʈ�� ��ſ� ���Ű. ���� ����.
        SecretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I=';

type
  TTfrmExample = class(TForm)
    Label3: TLabel;
    Label4: TLabel;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    btnJoinMember: TButton;
    btnCheckIsMember: TButton;
    btnCheckID: TButton;
    GroupBox11: TGroupBox;
    GroupBox4: TGroupBox;
    btnUpdateContact: TButton;
    btnRegistContact: TButton;
    btnListContact: TButton;
    GroupBox16: TGroupBox;
    btnGetCorpInfo: TButton;
    btnUpdateCorpInfo: TButton;
    txtCorpNum: TEdit;
    txtUserID: TEdit;
    btnRequestJob: TButton;
    txtJobID: TEdit;
    btnGetJobState: TButton;
    btnListActiveJob: TButton;
    btnSearch: TButton;
    btnSummary: TButton;
    Label1: TLabel;
    Label2: TLabel;
    btnGetTaxinvoice: TButton;
    btnGetXML: TButton;
    btnGetFlatRatePopUpURL: TButton;
    btnGetFlatRateState: TButton;
    btnGetCertificatePopUpURL: TButton;
    btnGetCertificateExpireDate: TButton;
    StringGrid1: TStringGrid;
    btnGetChargeInfo: TButton;
    txtntsconfirmNum: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnGetPopbillURL_LOGIN: TButton;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox7: TGroupBox;
    GroupBox10: TGroupBox;
    btnGetPopbillURL_CHRG: TButton;
    btnGetBalance: TButton;
    btnGetPartnerBalance: TButton;
    btnGetPartnerURL_CHRG: TButton;
    btnGetPopUpURL: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCheckIsMemberClick(Sender: TObject);
    procedure btnCheckIDClick(Sender: TObject);
    procedure btnJoinMemberClick(Sender: TObject);
    procedure btnGetBalanceClick(Sender: TObject);
    procedure btnGetPartnerBalanceClick(Sender: TObject);
    procedure btnRegistContactClick(Sender: TObject);
    procedure btnListContactClick(Sender: TObject);
    procedure btnUpdateContactClick(Sender: TObject);
    procedure btnGetCorpInfoClick(Sender: TObject);
    procedure btnUpdateCorpInfoClick(Sender: TObject);
    procedure btnRequestJobClick(Sender: TObject);
    procedure btnGetJobStateClick(Sender: TObject);
    procedure btnListActiveJobClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnSummaryClick(Sender: TObject);
    procedure btnGetTaxinvoiceClick(Sender: TObject);
    procedure btnGetXMLClick(Sender: TObject);
    procedure btnGetCertificatePopUpURLClick(Sender: TObject);
    procedure btnGetFlatRatePopUpURLClick(Sender: TObject);
    procedure btnGetCertificateExpireDateClick(Sender: TObject);
    procedure btnGetFlatRateStateClick(Sender: TObject);
    procedure btnGetChargeInfoClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnGetPopbillURL_LOGINClick(Sender: TObject);
    procedure btnGetPopbillURL_CHRGClick(Sender: TObject);
    procedure btnGetPartnerURL_CHRGClick(Sender: TObject);
    procedure btnGetPopUpURLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TfrmExample: TTfrmExample;
  htTaxinvoiceService : THometaxTIService;

implementation

{$R *.DFM}

procedure TTfrmExample.FormCreate(Sender: TObject);
begin
        htTaxinvoiceService := THometaxTIService.Create(LinkID,SecretKey);

        //����ȯ�� ������, true(���߿�), false(�����)
        htTaxinvoiceService.IsTest := true;
        
        //Exception ó�� ������. �̱���� true(�⺻��) 
        htTaxinvoiceService.IsThrowException := true;

        StringGrid1.Cells[0,0] := '����/����';
        StringGrid1.Cells[1,0] := '�ۼ�����';
        StringGrid1.Cells[2,0] := '��������';
        StringGrid1.Cells[3,0] := '��������';
        StringGrid1.Cells[4,0] := '�ŷ�ó';
        StringGrid1.Cells[5,0] := '�ŷ�ó ����ڹ�ȣ';
        StringGrid1.Cells[6,0] := '��������';
        StringGrid1.Cells[7,0] := '���ް���';
        StringGrid1.Cells[8,0] := '��������';
        StringGrid1.Cells[9,0] := '����û���ι�ȣ';


end;
Function BoolToStr(b:Boolean):String;
begin 
    if b = true then BoolToStr:='True'; 
    if b = false then BoolToStr:='False'; 
end;
procedure TTfrmExample.btnCheckIsMemberClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { �ش� ������� ��Ʈ�� ����ȸ�� ���Կ��θ� Ȯ���մϴ�.                 }
        { - LinkID�� ���������� �����Ǿ� �ִ� ��ũ���̵� �Դϴ�. (41������)    }
        {**********************************************************************}
        
        try
                response := htTaxinvoiceService.CheckIsMember(txtCorpNum.text, LinkID);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage(IntToStr(response.code) + ' | ' +  response.Message);

end;

procedure TTfrmExample.btnCheckIDClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { ȸ������(JoinMember API)�� ȣ���ϱ� �� ���̵� �ߺ��� Ȯ���մϴ�.     }
        {**********************************************************************}
        
        try
                response := htTaxinvoiceService.CheckID(txtUserID.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage(IntToStr(response.code) + ' | ' +  response.Message);


end;

procedure TTfrmExample.btnJoinMemberClick(Sender: TObject);
var
        response : TResponse;
        joinInfo : TJoinForm;
begin
        {**********************************************************************}
        {    ��Ʈ���� ����ȸ������ ȸ�������� ��û�մϴ�.                      }
        {    ���̵� �ߺ�Ȯ���� btnCheckIDClick ���ν����� �����Ͻñ� �ٶ��ϴ�. }
        {**********************************************************************}

        // ��ũ���̵�
        joinInfo.LinkID := LinkID;

        // ����ڹ�ȣ '-' ����, 10�ڸ�
        joinInfo.CorpNum := '4364364364';

        // ��ǥ�ڼ���, �ִ� 30��
        joinInfo.CEOName := '��ǥ�ڼ���';

        // ��ȣ��, �ִ� 70��
        joinInfo.CorpName := '��ũ���';

        // �ּ�, �ִ� 300��
        joinInfo.Addr := '�ּ�';

        // ����, �ִ� 40��
        joinInfo.BizType := '����';

        // ����, �ִ� 40��
        joinInfo.BizClass := '����';

        // ���̵�, 6���̻� 20�� �̸�
        joinInfo.ID     := 'userid';

        // ��й�ȣ, 6���̻� 20�� �̸�
        joinInfo.PWD    := 'pwd_must_be_long_enough';

        // ����ڸ�, �ִ� 30��
        joinInfo.ContactName := '����ڸ�';

        // ����� ����ó, �ִ� 20��
        joinInfo.ContactTEL :='070-4304-2991';

        // ����� �޴�����ȣ, �ִ� 20��
        joinInfo.ContactHP := '010-000-1111';

        // ����� �ѽ���ȣ, �ִ� 20��
        joinInfo.ContactFAX := '02-6442-9700';

        // ����� ����, �ִ� 70��
        joinInfo.ContactEmail := 'code@linkhub.co.kr';
        
        try
                response := htTaxinvoiceService.JoinMember(joinInfo);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage(IntToStr(response.code) + ' | ' +  response.Message);

end;

procedure TTfrmExample.btnGetBalanceClick(Sender: TObject);
var
        balance : Double;
begin
        {**********************************************************************}
        { ����ȸ���� �ܿ�����Ʈ�� Ȯ���մϴ�. ���ݹ���� ���������� �ƴ�       }
        { ��Ʈ�ʰ����� ��� ��Ʈ�� �ܿ�����Ʈ Ȯ��(GetPartnerBalance API)��    }
        { �̿��Ͻñ� �ٶ��ϴ�                                                  }
        {**********************************************************************}
        
        try
                balance := htTaxinvoiceService.GetBalance(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('�ܿ�����Ʈ : ' + FloatToStr(balance));

end;

procedure TTfrmExample.btnGetPartnerBalanceClick(Sender: TObject);
var
        balance : Double;
begin
        {**********************************************************************}
        { ��Ʈ���� �ܿ�����Ʈ�� Ȯ���մϴ�. ���ݹ���� ��Ʈ�ʰ����� �ƴ�       }
        { ���������� ��� ����ȸ�� �ܿ�����Ʈ Ȯ��(GetBalance API)��           }
        { �̿��Ͻñ� �ٶ��ϴ�                                                  }
        {**********************************************************************}
        
        try
                balance := htTaxinvoiceService.GetPartnerBalance(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('�ܿ�����Ʈ : ' + FloatToStr(balance));

end;

procedure TTfrmExample.btnRegistContactClick(Sender: TObject);
var
        response : TResponse;
        joinInfo : TJoinContact;
begin
        {**********************************************************************}
        { ����ȸ���� ����ڸ� �űԷ� ����մϴ�.                               }
        {**********************************************************************}

        // [�ʼ�] ����� ���̵� (6�� �̻� 20�� �̸�)
        joinInfo.id := 'testkorea1004_01';
        
        // [�ʼ�] ��й�ȣ (6�� �̻� 20�� �̸�)
        joinInfo.pwd := 'thisispassword';

        // [�ʼ�] ����ڸ�(�ѱ��̳� ���� 30�� �̳�)
        joinInfo.personName := '����ڼ���';

        // [�ʼ�] ����ó
        joinInfo.tel := '070-4304-2991';

        // �޴�����ȣ
        joinInfo.hp := '010-1111-2222';

        // �ѽ���ȣ
        joinInfo.fax := '02-6442-9700';
        
        // [�ʼ�] �̸���
        joinInfo.email := 'test@test.com';

        // ȸ����ȸ ���ѿ���, true-ȸ����ȸ / false-������ȸ
        joinInfo.searchAllAllowYN := false;

        // ������ ���ѿ���
        joinInfo.mgrYN := false;

        try
                response := htTaxinvoiceService.RegistContact(txtCorpNum.text, joinInfo);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage(IntToStr(response.code) + ' | ' +  response.Message);
end;

procedure TTfrmExample.btnListContactClick(Sender: TObject);
var
        InfoList : TContactInfoList;
        tmp : string;
        i : Integer;
begin
        {**********************************************************************}
        { ����ȸ���� ����� ����� Ȯ���մϴ�.                                 }
        {**********************************************************************}

        try
                InfoList := htTaxinvoiceService.ListContact(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;
        tmp := 'id | email | hp | personName | searchAllAlloyYN | tel | fax | mgrYN | regDT | state' + #13;
        for i := 0 to Length(InfoList) -1 do
        begin
            tmp := tmp + InfoList[i].id + ' | ';
            tmp := tmp + InfoList[i].email + ' | ';
            tmp := tmp + InfoList[i].hp + ' | ';
            tmp := tmp + InfoList[i].personName + ' | ';
            tmp := tmp + BoolToStr(InfoList[i].searchAllAllowYN) + ' | ';
            tmp := tmp + InfoList[i].tel + ' | ';
            tmp := tmp + InfoList[i].fax + ' | ';
            tmp := tmp + BoolToStr(InfoList[i].mgrYN) + ' | ';
            tmp := tmp + InfoList[i].regDT + ' | ';
            tmp := tmp + IntToStr(InfoList[i].state) + #13;
        end;

        ShowMessage(tmp);
end;

procedure TTfrmExample.btnUpdateContactClick(Sender: TObject);
var
        contactInfo : TContactInfo;
        response : TResponse;
begin
        {**********************************************************************}
        { ����ȸ���� ����� ������ �����մϴ�.                                 }
        {**********************************************************************}

        contactInfo := TContactInfo.Create;

        // ����� ���̵�
        contactInfo.id := 'testkorea';
        
        // ����ڸ�
        contactInfo.personName := '�׽�Ʈ �����';

        // ����ó
        contactInfo.tel := '070-4304-2991';

        // �޴�����ȣ
        contactInfo.hp := '010-4324-1111';

        // �̸��� �ּ�
        contactInfo.email := 'test@test.com';
        
        // �ѽ���ȣ
        contactInfo.fax := '02-6442-9799';

        // ��ȸ����, true(ȸ����ȸ), false(������ȸ)
        contactInfo.searchAllAllowYN := true;

        // �����ڱ��� ��������
        contactInfo.mgrYN := false; 

        try
                response := htTaxinvoiceService.UpdateContact(txtCorpNum.text, contactInfo, txtUserID.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage(IntToStr(response.code) + ' | ' +  response.Message);
end;

procedure TTfrmExample.btnGetCorpInfoClick(Sender: TObject);
var
        corpInfo : TCorpInfo;
        tmp : string;
begin
        {**********************************************************************}
        { ����ȸ���� ȸ�������� Ȯ���մϴ�.                                    }
        {**********************************************************************}

        try
                corpInfo := htTaxinvoiceService.GetCorpInfo(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'CorpName : ' + corpInfo.CorpName + #13;
        tmp := tmp + 'CeoName : ' + corpInfo.CeoName + #13;
        tmp := tmp + 'BizType : ' + corpInfo.BizType + #13;
        tmp := tmp + 'BizClass : ' + corpInfo.BizClass + #13;
        tmp := tmp + 'Addr : ' + corpInfo.Addr + #13;

        ShowMessage(tmp);
end;

procedure TTfrmExample.btnUpdateCorpInfoClick(Sender: TObject);
var
        corpInfo : TCorpInfo;
        response : TResponse;
begin
        {**********************************************************************}
        { ����ȸ���� ȸ�������� �����մϴ�.                                    }
        {**********************************************************************}

        corpInfo := TCorpInfo.Create;

        // ��ǥ�ڸ�, �ִ� 30��
        corpInfo.ceoname := '��ǥ�ڸ�';

        // ��ȣ, �ִ� 70��
        corpInfo.corpName := '��ȣ';

        // ����, �ִ� 40��
        corpInfo.bizType := '����';

        // ����, �ִ� 40��
        corpInfo.bizClass := '����';

        // �ּ�, �ִ� 300��
        corpInfo.addr := '����Ư���� ������ ������� 517';
        
        try
                response := htTaxinvoiceService.UpdateCorpInfo(txtCorpNum.text, corpInfo);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage(IntToStr(response.code) + ' | ' +  response.Message);
end;

procedure TTfrmExample.btnRequestJobClick(Sender: TObject);
var
        queryType : EnumQueryType;
        DType : String;
        SDate: String;
        EDate: String;
        jobID: String;
begin
        {**********************************************************************}
        { ����(����)��꼭 ����/���� ���� ������ ��û�մϴ�.                   }
        {  - ���� ��û�� ��ȯ�Ǵ� �۾����̵�(jobID)�� ��ȿ�ð��� 1�ð��Դϴ�.  }
        {**********************************************************************}
        
        // ���ڼ��ݰ�꼭 ���� SELL- ����, BUY- ����, TRUSTEE-����Ź
        queryType := SELL;

        // ���� ���� ���� W-�ۼ�����, I-��������, S-��������
        DType := 'W';

        // ��������, ��������(yyyyMMdd)
        SDate := '20160901';

        // ��������, ��������(yyyyMMdd)
        EDate := '20161031';
        
        try
                jobID := htTaxinvoiceService.RequestJob(txtCorpNum.text, queryType, DType, SDate, EDate);

        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('jobID : ' + jobID);
        txtjobID.text := jobID;

end;

procedure TTfrmExample.btnGetJobStateClick(Sender: TObject);
var
        jobInfo : THomeTaxTIJobInfo;
        tmp : String;
begin
        {**********************************************************************}
        { ������û�� ���� ���¸� Ȯ���մϴ�.                                   }
        { - �����׸� ���� ������ "[API �����Ŵ���] > 3.2.2. GetJobState      }
        {   ���� ���� Ȯ��" �� �����Ͻñ� �ٶ��ϴ�.                            }
        {**********************************************************************}

        try
                jobInfo := htTaxinvoiceService.GetJobState(txtCorpNum.text, txtJobId.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'jobID : '+ jobInfo.jobID + #13;
        tmp := tmp + 'jobState : '+ IntToStr(jobInfo.jobState) + #13;
        tmp := tmp + 'queryType : ' + jobInfo.queryType  + #13;
        tmp := tmp + 'queryDateType : ' + jobInfo.queryDateType  + #13;
        tmp := tmp + 'queryStDate : ' + jobInfo.queryStDate + #13;
        tmp := tmp + 'queryEnDate : ' + jobInfo.queryEnDate + #13;
        tmp := tmp + 'errorCode : ' + IntToStr(jobInfo.errorCode) + #13;
        tmp := tmp + 'errorReason : ' + jobInfo.errorReason + #13;
        tmp := tmp + 'jobStartDT : ' + jobInfo.jobStartDT + #13;
        tmp := tmp + 'jobEndDT : ' + jobInfo.jobEndDT + #13;
        tmp := tmp + 'collectCount : ' + IntToStr(jobInfo.collectCount) + #13;
        tmp := tmp + 'regDT : ' + jobInfo.regDT + #13;

        tmp := tmp + #13;

        ShowMessage(tmp);
end;

procedure TTfrmExample.btnListActiveJobClick(Sender: TObject);
var
        jobList : THomeTaxTIJobInfoList;
        tmp : String;
        i : Integer;
begin
        {**********************************************************************}
        { 1�ð� �̳� ���� ��û�� �۾����̵� ����� Ȯ���մϴ�.                 }
        { - �����׸� ���� ������ "[API �����Ŵ���] > 3.2.3. ListActiveJob    }
        {   �������� ��� Ȯ��" �� �����Ͻñ� �ٶ��ϴ�.                        }
        {**********************************************************************}

        try
                jobList := htTaxinvoiceService.ListActiveState(txtCorpNum.text);

        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'jobID | jobState | queryType | queryDateType | queryStDate | queryEnDate | errorCode | errorReason | jobStartDT | jobEndDT | collectCount | regDT ' + #13;

        for i := 0 to Length(jobList) -1 do
        begin
            tmp := tmp + jobList[i].jobID + ' | ';
            tmp := tmp + IntToStr(jobList[i].jobState) + ' | ';
            tmp := tmp + jobList[i].queryType + ' | ';
            tmp := tmp + jobList[i].queryDateType + ' | ';
            tmp := tmp + jobList[i].queryStDate + ' | ';
            tmp := tmp + jobList[i].queryEnDate + ' | ';
            tmp := tmp + IntToStr(jobList[i].errorCode) + ' | ';
            tmp := tmp + jobList[i].errorReason + ' | ';
            tmp := tmp + jobList[i].jobStartDT + ' | ';
            tmp := tmp + jobList[i].jobEndDT + ' | ';
            tmp := tmp + IntToStr(jobList[i].collectCount) + ' | ';
            tmp := tmp + jobList[i].regDT + #13;
        end;

        txtJobId.text := jobList[0].jobID;
        ShowMessage(tmp);
end;

procedure TTfrmExample.btnSearchClick(Sender: TObject);
var
        docType : array of string;
        taxType : array of string;
        purposeType : array of string;
        taxRegIDType : string;
        taxRegID : string;
        taxRegIDYN : string;
        page : Integer;
        perPage : Integer;
        order : String;
        searchInfo : THomeTaxTISearchList;
        tmp : string;
        i : Integer; 
begin
        {**********************************************************************}
        { ����(����)��꼭 ����/���� ������ ���� ����� ��ȸ�մϴ�.            }
        {  - ���� ��û�� ��ȯ�Ǵ� �۾����̵�(jobID)�� ��ȿ�ð��� 1�ð��Դϴ�.  }
        {**********************************************************************}

        // �������� �迭, N - �Ϲ� ����(����)��꼭, M - ����(����)���ݰ�꼭
        SetLength(docType, 2);
        docType[0] := 'N';
        docType[1] := 'M';

        // �������� �迭, T - ����, N - �鼼, Z - ����
        SetLength(taxType, 3);
        taxType[0] := 'T';
        taxType[1] := 'Z';
        taxType[2] := 'N';

        // ����/û�� �迭, R - ����, C - û��, N - ����
        SetLength(purposeType, 3);
        purposeType[0] := 'R';
        purposeType[1] := 'C';
        purposeType[2] := 'N';  

        // ��������ڹ�ȣ ����� ����, ����-��ü��ȸ, S-������, B-���޹޴���, T-��Ź��
        TaxRegIDType := '';

        // ��������ȣ, �޸�(,)�� �����Ͽ� ����.  ex) '1234,0001'
        TaxRegID := '';

        //��������ȣ ����,  ���� - ��ü��ȸ, 0-��������ȣ ����, 1-��������ȣ ����
        TaxRegIDYN := '';

        // ��������ȣ 
        Page := 1;

        // �������� �˻�����
        PerPage := 10;

        // ���Ĺ���, D-��������, A-��������
        Order := 'D';

        try
                searchInfo := htTaxinvoiceService.Search(txtCorpNum.text, txtJobId.text,DocType,TaxType, PurposeType, TaxRegIDType, TaxRegID, TaxRegIDYN, Page, PerPage, Order);

        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'code (�����ڵ�) : ' + IntToStr(searchInfo.code) + #13;
        tmp := tmp + 'total (�� �˻���� �Ǽ�) : ' + IntToStr(searchInfo.total) + #13;
        tmp := tmp + 'perPage (�������� �˻�����) : ' + IntToStr(searchInfo.perPage) + #13;
        tmp := tmp + 'pageNum (������ ��ȣ) : ' + IntToStr(searchInfo.pageNum) + #13;
        tmp := tmp + 'pageCount (������ ����) : ' + IntToStr(searchInfo.pageCount)+ #13;
        tmp := tmp + 'message (���� �޽���) : ' + searchInfo.message + #13 + #13;


        // ����(����)��꼭 ���� ���
        //  APIȣ��� ��ȯ�Ǵ� �߰����� ����(����)��꼭 �׸���

        //  [��ũ���]�˺� -Ȩ�ý� ���ڼ��ݰ�꼭 API �����Ŵ��� '4.1.1. Search' �� �����Ͻñ� �ٶ��ϴ�.
        for i := 0 to length(searchInfo.list) - 1 do
        begin
                StringGrid1.Cells[0, i+1] := searchInfo.list[i].invoiceType;        
                StringGrid1.Cells[1, i+1] := searchInfo.list[i].writeDate;
                StringGrid1.Cells[2, i+1] := searchInfo.list[i].issueDate;
                StringGrid1.Cells[3, i+1] := searchInfo.list[i].sendDate;
                StringGrid1.Cells[4, i+1] := searchInfo.list[i].invoiceeCorpName;
                StringGrid1.Cells[5, i+1] := searchInfo.list[i].invoiceeCorpNum;
                StringGrid1.Cells[6, i+1] := searchInfo.list[i].taxType;
                StringGrid1.Cells[7, i+1] := searchInfo.list[i].supplyCostTotal;

                if searchInfo.list[i].modifyYN then
                begin
                        StringGrid1.Cells[8, i+1] := '����';
                end
                else
                        StringGrid1.Cells[8, i+1] := '�Ϲ�';

                StringGrid1.Cells[9, i+1] := searchInfo.list[i].ntsconfirmNum;

        end;

        ShowMessage(tmp);
end;

procedure TTfrmExample.btnSummaryClick(Sender: TObject);
var
        docType : array of string;
        taxType : array of string;
        purposeType : array of string;
        taxRegIDType : string;
        taxRegID : string;
        taxRegIDYN : string;
        summaryInfo : TTaxinvoiceSummary;
        tmp : string;
begin
        {**********************************************************************}
        { ����(����)��꼭 ����/���� ������ ���� ��� ��������� ��ȸ�մϴ�.   }
        {  - ���� ��û�� ��ȯ�Ǵ� �۾����̵�(jobID)�� ��ȿ�ð��� 1�ð��Դϴ�.  }
        {**********************************************************************}

        // �������� �迭, N - �Ϲ� ����(����)��꼭, M - ����(����)���ݰ�꼭
        SetLength(docType, 2);
        docType[0] := 'N';
        docType[1] := 'M';

        // �������� �迭, T - ����, N - �鼼, Z - ����
        SetLength(taxType, 3);
        taxType[0] := 'T';
        taxType[1] := 'Z';
        taxType[2] := 'N';

        // ����/û�� �迭, R - ����, C - û��, N - ����
        SetLength(purposeType, 3);
        purposeType[0] := 'R';
        purposeType[1] := 'C';
        purposeType[2] := 'N';

        // ��������ڹ�ȣ ����� ����, S-������, B-���޹޴���, T-��Ź��
        TaxRegIDType := 'S';

        // ��������ȣ, �޸�(,)�� �����Ͽ� ���� ex)0001,0007
        taxRegID := '';

        //��������ȣ ����, ���� - ��ü��ȸ, 0-��������ȣ ����, 1-��������ȣ ����
        TaxRegIDYN := '';

        try
                summaryInfo := htTaxinvoiceService.Summary(txtCorpNum.text, txtJobId.text,DocType,TaxType, PurposeType, TaxRegIDType, TaxRegID, TaxRegIDYN);

        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'count (���� ��� �Ǽ�) : ' + IntToStr(summaryInfo.count) + #13;
        tmp := tmp + 'supplyCostTotal (���ް��� �հ�) : ' + IntToStr(summaryInfo.supplyCostTotal) + #13;
        tmp := tmp + 'taxTotal (���� �հ�) : ' + IntToStr(summaryInfo.taxTotal) + #13;
        tmp := tmp + 'amountTotal (�հ� �ݾ�) : ' + IntToStr(summaryInfo.amountTotal) + #13;
        
        ShowMessage(tmp);

end;

procedure TTfrmExample.btnGetTaxinvoiceClick(Sender: TObject);
var
        taxinvoice : THomeTaxTaxinvoice;
        tmp : string;
        ntsConfirmNum : string;
        i : Integer;
begin
        {**********************************************************************}
        { 1���� ����(����)��꼭 �������� ��ȸ�մϴ�.                        }
        {  - �����׸� ���� ������ "[API �����Ŵ���] > 4.1.2. GetTaxinvoice   }
        {    ������ Ȯ�� - JSON" �� �����Ͻñ� �ٶ��ϴ�.                     }
        {**********************************************************************}

        ntsConfirmNum := txtntsconfirmNum.Text;
        
        try
                taxinvoice := htTaxinvoiceService.getTaxinvoice(txtCorpNum.text,ntsConfirmNum);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := tmp + 'writeDate (�ۼ�����) : ' + taxinvoice.writeDate + #13;
        tmp := tmp + 'issueDT (�����Ͻ�) : ' + taxinvoice.issueDT + #13;
        tmp := tmp + 'invoiceType (���ڼ��ݰ�꼭 ����) : ' + IntToStr(taxinvoice.invoiceType) + #13;
        tmp := tmp + 'taxType (��������) : ' + taxinvoice.taxType + #13;
        tmp := tmp + 'supplyCostTotal (���ް��� �հ�) : ' + taxinvoice.supplyCostTotal + #13;
        tmp := tmp + 'taxTotal (�����հ�) : ' + taxinvoice.taxTotal + #13;
        tmp := tmp + 'totalAmount (�հ�ݾ�) : ' + taxinvoice.totalAmount + #13;
        tmp := tmp + 'purposeType (����/û��) : ' + taxinvoice.purposeType + #13;
        tmp := tmp + 'cash (����) : ' + taxinvoice.cash + #13;
        tmp := tmp + 'chkBill (��ǥ) : ' + taxinvoice.chkBill + #13;
        tmp := tmp + 'credit (�ܻ�) : ' + taxinvoice.credit + #13;
        tmp := tmp + 'note (����) : ' + taxinvoice.note + #13;
        tmp := tmp + 'remark1 (���1) : ' + taxinvoice.remark1 + #13;
        tmp := tmp + 'remark2 (���2) : ' + taxinvoice.remark2 + #13;
        tmp := tmp + 'remark3 (���3) : ' + taxinvoice.remark3 + #13;
        tmp := tmp + 'ntsconfirmNum (����û���ι�ȣ) : ' + taxinvoice.ntsconfirmNum + #13;
        tmp := tmp + 'modifyCode (���������ڵ�) : ' + IntToStr(taxinvoice.modifyCode) + #13;
        tmp := tmp + 'orgNTSConfirmNum (���� ���ڼ��ݰ�꼭 ����û ���ι�ȣ) : ' + taxinvoice.orgNTSConfirmNum + #13 +#13;

        tmp := tmp + '========����(����)��꼭 ������ ����========' +#13;
        tmp := tmp + 'invoicerCorpNum (������ ����ڹ�ȣ) : ' + taxinvoice.invoicerCorpNum +#13;
        tmp := tmp + 'invoicerMgtKey (������ ����������ȣ) : ' + taxinvoice.invoicerMgtKey +#13;
        tmp := tmp + 'invoicerTaxRegID (������ ��������ȣ) : ' + taxinvoice.invoicerTaxRegID +#13;
        tmp := tmp + 'invoicerCorpName (������ ��ȣ) : ' + taxinvoice.invoicerCorpName +#13;
        tmp := tmp + 'invoicerCEOName (������ ��ǥ�� ����) : ' + taxinvoice.invoicerCEOName +#13;
        tmp := tmp + 'invoicerAddr (������ �ּ�) : ' + taxinvoice.invoicerAddr +#13;
        tmp := tmp + 'invoicerBizType (������ ����) : ' + taxinvoice.invoicerBizType +#13;
        tmp := tmp + 'invoicerBizClass (������ ����) : ' + taxinvoice.invoicerBizClass +#13;
        tmp := tmp + 'invoicerContactName (������ ����� ����) : ' + taxinvoice.invoicerContactName +#13;
        tmp := tmp + 'invoicerTEL (������ ����� ����ó) : ' + taxinvoice.invoicerTEL +#13;
        tmp := tmp + 'invoicerEmail (������ �̸���) : ' + taxinvoice.invoicerEmail +#13 +#13;

        tmp := tmp + '=========����(����)��꼭 ���޹޴��� ����=========' +#13;
        tmp := tmp + 'invoiceeCorpNum (���޹޴��� ����ڹ�ȣ) : ' + taxinvoice.invoiceeCorpNum +#13;
        tmp := tmp + 'invoiceeType (���޹޴��� ����) : ' + taxinvoice.invoiceeType +#13;
        tmp := tmp + 'invoiceeTaxRegID (���޹޴��� ������ڹ�ȣ) : ' + taxinvoice.invoiceeTaxRegID +#13;
        tmp := tmp + 'invoiceeCorpName (���޹޴��� ��ȣ) : ' + taxinvoice.invoiceeCorpName +#13;
        tmp := tmp + 'invoiceeCEOName (���޹޴��� ��ǥ�� ����) : ' + taxinvoice.invoiceeCEOName +#13;
        tmp := tmp + 'invoiceeAddr (���޹޴��� �ּ�) : ' + taxinvoice.invoiceeAddr +#13;
        tmp := tmp + 'invoiceeBizType (���޹޴��� ����) : ' + taxinvoice.invoiceeBizType +#13;
        tmp := tmp + 'invoiceeBizClass (���޹޴��� ����) : ' + taxinvoice.invoiceeBizClass +#13;
        tmp := tmp + 'invoiceeContactName1 (���޹޴��� ����� ����) : ' + taxinvoice.invoiceeContactName1 +#13;
        tmp := tmp + 'invoiceeTEL1 (���޹޴��� ����� ����ó) : ' + taxinvoice.invoiceeTEL1 +#13;
        tmp := tmp + 'invoiceeEmail1 (���޹޴��� �̸���) : ' + taxinvoice.invoiceeEmail1 +#13 +#13;

        tmp := tmp + '========���׸�========' + #13;
        tmp := tmp + 'serialNum | purchaseDT | itemName | spec | qty | unitCost | supplyCost | tax | remark' + #13;
        
        for i:= 0 to Length(taxinvoice.detailList)-1 do
        begin
            tmp := tmp + IntToStr(taxinvoice.detailList[i].serialNum) + ' | ' +
                         taxinvoice.detailList[i].purchaseDT + ' | ' +
                         taxinvoice.detailList[i].itemName + ' | ' +
                         taxinvoice.detailList[i].spec + ' | ' +
                         taxinvoice.detailList[i].qty + ' | ' +
                         taxinvoice.detailList[i].unitCost + ' | ' +
                         taxinvoice.detailList[i].supplyCost + ' | ' +
                         taxinvoice.detailList[i].tax + ' | ' +
                         taxinvoice.detailList[i].remark + #13 ;

        end;
        
        ShowMessage(tmp);
end;

procedure TTfrmExample.btnGetXMLClick(Sender: TObject);
var
        response : TGetXMLResponse;
        tmp : string;
        ntsConfirmNum : string;
begin
        {**********************************************************************}
        { 1���� ����(����)��꼭 �������� ��ȸ�մϴ�. (XML����)              }
        {  - �����׸� ���� ������ "[API �����Ŵ���] > 4.1.2. GetTaxinvoice   }
        {    ������ Ȯ�� - JSON" �� �����Ͻñ� �ٶ��ϴ�.                     }
        {**********************************************************************}

        ntsConfirmNum := txtntsconfirmNum.Text;
        
        try
                response := htTaxinvoiceService.getXML(txtCorpNum.text,ntsConfirmNum);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'ResultCode (�����ڵ�) : ' + IntToStr(response.ResultCode) + #13;
        tmp := tmp + 'Message (����û���ι�ȣ) : ' + response.Message + #13;
        tmp := tmp + 'retObject (XML����) : ' + #13 + response.retObject;

        ShowMessage(tmp);

end;

procedure TTfrmExample.btnGetCertificatePopUpURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        { ���������� ��� �˾� URL�� ��ȯ�մϴ�.                               }
        { - URL ������å�� ���� ��ȯ�� URL�� 30���� ��ȿ�ð��� �����ϴ�.       }
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.GetCertificatePopUpURL(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('ResultURL is ' + #13 + resultURL);
end;

procedure TTfrmExample.btnGetFlatRatePopUpURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        { ������ ���� ��û �˾� URL�� ��ȯ�մϴ�.                            }
        { - URL ������å�� ���� ��ȯ�� URL�� 30���� ��ȿ�ð��� �����ϴ�.       }
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.GetFlatRatePopUpURL(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('ResultURL is ' + resultURL);
end;

procedure TTfrmExample.btnGetCertificateExpireDateClick(Sender: TObject);
var
        expires : String;
begin
        {**********************************************************************}
        { �˺��� ��ϵ� Ȩ�ý� ���������� �������ڸ� Ȯ���մϴ�.               }
        {**********************************************************************}

        try
                expires := htTaxinvoiceService.GetCertificateExpireDate(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('ExpireDate is : ' + expires);
end;

procedure TTfrmExample.btnGetFlatRateStateClick(Sender: TObject);
var
        stateInfo : THometaxTIFlatRate;
        tmp : String;
begin
        {**********************************************************************}
        { ������ ���� ���¸� Ȯ���մϴ�.                                     }
        {**********************************************************************}

        try
                stateInfo := htTaxinvoiceService.GetFlatRateState(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'referenceID (����ڹ�ȣ) : ' + stateInfo.referenceID + #13;
        tmp := tmp + 'contractDT (������ ���� �����Ͻ�) : ' + stateInfo.contractDT + #13;
        tmp := tmp + 'useEndDate (������ ���� �����Ͻ�) : ' + stateInfo.useEndDate + #13;
        tmp := tmp + 'baseDate (�ڵ����� ������) : ' + IntToStr(stateInfo.baseDate) + #13;
        tmp := tmp + 'state (������ ���� ����) : ' + IntToStr(stateInfo.state) + #13;
        tmp := tmp + 'closeRequestYN (������ ������û ����) : ' + BoolToStr(stateInfo.closeRequestYN) + #13;
        tmp := tmp + 'useRestrictYN (������ ������� ����) : ' + BoolToStr(stateInfo.useRestrictYN) + #13;
        tmp := tmp + 'closeOnExpired (������ ����� ���� ����) : ' + BoolToStr(stateInfo.closeOnExpired) + #13;
        tmp := tmp + 'unPaidYN (�̼��� ���� ����) : ' + BoolToStr(stateInfo.unPaidYN) + #13;
        ShowMessage(tmp);
end;

procedure TTfrmExample.btnGetChargeInfoClick(Sender: TObject);
var
        chargeInfo : THometaxTIChargeInfo;
        tmp : String;
begin
        {**********************************************************************}
        { Ȩ�ý� ���ڼ��ݰ�꼭 ����  API ���� ���������� Ȯ���մϴ�.        }
        {**********************************************************************}

        try
                chargeInfo := htTaxinvoiceService.GetChargeInfo(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'unitCost (�ܰ�) : ' + chargeInfo.unitCost + #13;
        tmp := tmp + 'chargeMethod (��������) : ' + chargeInfo.chargeMethod + #13;
        tmp := tmp + 'rateSystem (��������) : ' + chargeInfo.rateSystem + #13;

        ShowMessage(tmp);
end;

procedure TTfrmExample.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
        if StringGrid1.Cells[9, Arow] <> '' then
        begin
                txtntsconfirmNum.Text := StringGrid1.Cells[9, Arow];
        end
        
end;

procedure TTfrmExample.btnGetPopbillURL_LOGINClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        {    �˺�(www.popbill.com)�� �α��ε� �˾� URL�� ��ȯ�մϴ�.           }
        {    URL ������å�� ���� ��ȯ�� URL�� 30���� ��ȿ�ð��� �����ϴ�.      }
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.getPopbillURL(txtCorpNum.Text, 'LOGIN');
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('�˺� �α��� URL' + #13 + resultURL);
end;

procedure TTfrmExample.btnGetPopbillURL_CHRGClick(Sender: TObject);
var
  resultURL : String;
begin
        {**********************************************************************}
        {    ����ȸ�� ����Ʈ ���� URL�� ��ȯ�մϴ�.                            }
        {    URL ������å�� ���� ��ȯ�� URL�� 30���� ��ȿ�ð��� �����ϴ�.      }
        {**********************************************************************}
        
        try
                resultURL := htTaxinvoiceService.getPopbillURL(txtCorpNum.Text, 'CHRG');
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('����Ʈ���� URL ' + #13 + resultURL);
end;


procedure TTfrmExample.btnGetPartnerURL_CHRGClick(Sender: TObject);
var
  resultURL : String;
begin
        {**********************************************************************}
        {    ��Ʈ�� ����Ʈ ���� URL�� ��ȯ�մϴ�.                              }
        {    URL ������å�� ���� ��ȯ�� URL�� 30���� ��ȿ�ð��� �����ϴ�.      }
        {**********************************************************************}
        
        try
                resultURL := htTaxinvoiceService.getPartnerURL(txtCorpNum.Text, 'CHRG');
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('��Ʈ�� ����Ʈ���� URL ' + #13 + resultURL);
end;

procedure TTfrmExample.btnGetPopUpURLClick(Sender: TObject);
var
  resultURL, NTSConfirmNum : String;
begin
        {**********************************************************************}
        {    Ȩ�ý� ���ڼ��ݰ�꼭 ���� �˾� URL�� ��ȯ�Ѵ�.                   }
        {    URL ������å�� ���� ��ȯ�� URL�� 30���� ��ȿ�ð��� �����ϴ�.      }
        {**********************************************************************}

        NTSConfirmNum := txtntsconfirmNum.text;

        try
                resultURL := htTaxinvoiceService.getPopUpURL(txtCorpNum.Text, NTSConfirmNum, txtUserID.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('Ȩ�ý� ���ڼ��ݰ�꼭 ���� �˾� URL ' + #13 + resultURL);
end;

end.
