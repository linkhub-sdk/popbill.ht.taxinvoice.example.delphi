{******************************************************************************}
{                                                                              }
{ 팝빌 홈택스 전자세금계산서 매입/매출 API Delphi SDK Example                  }
{                                                                              }
{ - 델파이 SDK 적용방법 안내 : http://blog.linkhub.co.kr/572                   }
{ - 업데이트 일자 : 2019-01-31                                                 }
{ - 연동 기술지원 연락처 : 1600-9854 / 070-4304-2991                           }
{ - 연동 기술지원 이메일 : code@linkhub.co.kr                                  }
{                                                                              }
{ <테스트 연동개발 준비사항>                                                   }
{ (1) 38, 41번 라인에 선언된 링크아이디(LinkID)와 비밀키(SecretKey)를          }
{    링크허브 가입시 메일로 발급받은 인증정보로 수정                           }
{ (2) 팝빌 개발용 사이트(test.popbill.com)에 연동회원으로 가입                 }
{ (3) 홈택스 인증처리를 합니다. (부서사용자등록 / 공인인증서 등록)             }
{    - [팝빌로그인] > [홈택스연동] > [환경설정] > [인증 관리] 메뉴             }
{    - 홈택스연동 인증 관리 팝업 URL(GetCertificatePopUpURL API) 반환된 URL을  }
{      을 이용하여 홈택스 인증 처리를 합니다.                                  }
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
        { - 인증정보(링크아이디, 비밀키)는 파트너의 연동회원을 식별하는        }
        {   인증에 사용되므로 유출되지 않도록 주의하시기 바랍니다              }
        { - 상업용 전환이후에도 인증정보는 변경되지 않습니다.                  }
        {**********************************************************************}

        // 링크아이디.
        LinkID = 'TESTER';

        // 파트너 통신용 비밀키. 유출 주의.
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
    StringGrid1: TStringGrid;
    btnGetChargeInfo: TButton;
    txtntsconfirmNum: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnGetAccessURL: TButton;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox7: TGroupBox;
    GroupBox10: TGroupBox;
    btnGetChargeURL: TButton;
    btnGetBalance: TButton;
    btnGetPartnerBalance: TButton;
    btnGetPartnerURL_CHRG: TButton;
    btnGetPopUpURL: TButton;
    GroupBox12: TGroupBox;
    btnGetCertificateExpireDate: TButton;
    btnGetCertificatePopUpURL: TButton;
    btnCheckCertValidation: TButton;
    btnRegistDeptUser: TButton;
    btnCheckDeptUser: TButton;
    btnCheckLoginDeptUser: TButton;
    btnDeleteDeptUser: TButton;
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
    procedure btnGetAccessURLClick(Sender: TObject);
    procedure btnGetChargeURLClick(Sender: TObject);
    procedure btnGetPartnerURL_CHRGClick(Sender: TObject);
    procedure btnGetPopUpURLClick(Sender: TObject);
    procedure btnCheckCertValidationClick(Sender: TObject);
    procedure btnRegistDeptUserClick(Sender: TObject);
    procedure btnCheckDeptUserClick(Sender: TObject);
    procedure btnCheckLoginDeptUserClick(Sender: TObject);
    procedure btnDeleteDeptUserClick(Sender: TObject);
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

        //연동환경 설정값, true(개발용), false(상업용)
        htTaxinvoiceService.IsTest := true;

        //Exception 처리 설정값. 미기재시 true(기본값)
        htTaxinvoiceService.IsThrowException := true;

        StringGrid1.Cells[0,0] := 'ntsconfirmNum';
        StringGrid1.Cells[1,0] := 'writeDate';
        StringGrid1.Cells[2,0] := 'issueDate';
        StringGrid1.Cells[3,0] := 'sendDate';
        StringGrid1.Cells[4,0] := 'taxType';
        StringGrid1.Cells[5,0] := 'purposeType';
        StringGrid1.Cells[6,0] := 'supplyCostTotal';
        StringGrid1.Cells[7,0] := 'taxTotal';
        StringGrid1.Cells[8,0] := 'totalAmount';
        StringGrid1.Cells[9,0] := 'remark1';
        StringGrid1.Cells[10,0] := 'invoiceType';
        StringGrid1.Cells[11,0] := 'modifyYN';
        StringGrid1.Cells[12,0] := 'orgNTSConfirmNum';
        StringGrid1.Cells[13,0] := 'purchaseDate';
        StringGrid1.Cells[14,0] := 'itemName';
        StringGrid1.Cells[15,0] := 'spec';
        StringGrid1.Cells[16,0] := 'qty';
        StringGrid1.Cells[17,0] := 'unitCost';
        StringGrid1.Cells[18,0] := 'supplyCost';
        StringGrid1.Cells[19,0] := 'tax';
        StringGrid1.Cells[20,0] := 'remark';
        StringGrid1.Cells[21,0] := 'invoicerCorpNum';
        StringGrid1.Cells[22,0] := 'invoicerTaxRegID';
        StringGrid1.Cells[23,0] := 'invoicerCorpName';
        StringGrid1.Cells[24,0] := 'invoicerCEOName';
        StringGrid1.Cells[25,0] := 'invoicerEmail';
        StringGrid1.Cells[26,0] := 'invoiceeCorpNum';
        StringGrid1.Cells[27,0] := 'invoiceeType';
        StringGrid1.Cells[28,0] := 'invoiceeTaxRegID';
        StringGrid1.Cells[29,0] := 'invoiceeCorpName';
        StringGrid1.Cells[30,0] := 'invoiceeCEOName';
end;

Function BoolToStr(b:Boolean):String;
begin
    if b = true then BoolToStr:='True';
    if b = false then BoolToStr:='False';
end;

procedure TTfrmExample.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
        if StringGrid1.Cells[0, Arow] <> '' then
        begin
                txtntsconfirmNum.Text := StringGrid1.Cells[0, Arow];
        end
end;

procedure TTfrmExample.btnCheckIsMemberClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 해당 사업자의 파트너 연동회원 가입여부를 확인합니다.                 }
        { - LinkID는 인증정보에 설정되어 있는 링크아이디 입니다. (41번라인)    }
        {**********************************************************************}

        try
                response := htTaxinvoiceService.CheckIsMember(txtCorpNum.text, LinkID);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

procedure TTfrmExample.btnCheckIDClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 회원가입(JoinMember API)을 호출하기 전 아이디 중복을 확인합니다.     }
        {**********************************************************************}

        try
                response := htTaxinvoiceService.CheckID(txtUserID.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

procedure TTfrmExample.btnJoinMemberClick(Sender: TObject);
var
        response : TResponse;
        joinInfo : TJoinForm;
begin
        {**********************************************************************}
        {    파트너의 연동회원으로 회원가입을 요청합니다.                      }
        {    아이디 중복확인은 btnCheckIDClick 프로시져를 참조하시기 바랍니다. }
        {**********************************************************************}

        // 링크아이디
        joinInfo.LinkID := LinkID;

        // 사업자번호 '-' 제외, 10자리
        joinInfo.CorpNum := '1234567890';

        // 대표자성명, 최대 100자
        joinInfo.CEOName := '대표자성명';

        // 상호명, 최대 200자
        joinInfo.CorpName := '링크허브';

        // 주소, 최대 300자
        joinInfo.Addr := '주소';

        // 업태, 최대 100자
        joinInfo.BizType := '업태';

        // 종목, 최대 100자
        joinInfo.BizClass := '종목';

        // 아이디, 6자이상 50자 미만
        joinInfo.ID     := 'userid';

        // 비밀번호, 6자이상 20자 미만
        joinInfo.PWD    := 'pwd_must_be_long_enough';

        // 담당자명, 최대 100자
        joinInfo.ContactName := '담당자명';

        // 담당자 연락처, 최대 20자
        joinInfo.ContactTEL :='070-4304-2991';

        // 담당자 휴대폰번호, 최대 20자
        joinInfo.ContactHP := '010-000-1111';

        // 담당자 팩스번호, 최대 20자
        joinInfo.ContactFAX := '02-6442-9700';

        // 담당자 메일, 최대 100자
        joinInfo.ContactEmail := 'code@linkhub.co.kr';

        try
                response := htTaxinvoiceService.JoinMember(joinInfo);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

procedure TTfrmExample.btnGetBalanceClick(Sender: TObject);
var
        balance : Double;
begin
        {**********************************************************************}
        { 연동회원의 잔여포인트를 확인합니다. 과금방식이 연동과금이 아닌       }
        { 파트너과금인 경우 파트너 잔여포인트 확인(GetPartnerBalance API)를    }
        { 이용하시기 바랍니다                                                  }
        {**********************************************************************}

        try
                balance := htTaxinvoiceService.GetBalance(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('잔여포인트 : ' + FloatToStr(balance));
end;

procedure TTfrmExample.btnGetPartnerBalanceClick(Sender: TObject);
var
        balance : Double;
begin
        {**********************************************************************}
        { 파트너의 잔여포인트를 확인합니다. 과금방식이 파트너과금이 아닌       }
        { 연동과금인 경우 연동회원 잔여포인트 확인(GetBalance API)를           }
        { 이용하시기 바랍니다                                                  }
        {**********************************************************************}

        try
                balance := htTaxinvoiceService.GetPartnerBalance(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('잔여포인트 : ' + FloatToStr(balance));
end;

procedure TTfrmExample.btnRegistContactClick(Sender: TObject);
var
        response : TResponse;
        joinInfo : TJoinContact;
begin
        {**********************************************************************}
        { 연동회원의 담당자를 신규로 등록합니다.                               }
        {**********************************************************************}

        // [필수] 담당자 아이디 (6자 이상 50자 미만)
        joinInfo.id := 'testkorea';

        // [필수] 비밀번호 (6자 이상 20자 미만)
        joinInfo.pwd := 'thisispassword';

        // [필수] 담당자명(한글이나 영문 100자 이내)
        joinInfo.personName := '담당자성명';

        // [필수] 연락처 (최대 20자)
        joinInfo.tel := '070-4304-2991';

        // 휴대폰번호 (최대 20자)
        joinInfo.hp := '010-1111-2222';

        // 팩스번호 (최대 20자)
        joinInfo.fax := '02-6442-9700';

        // [필수] 이메일 (최대 100자)
        joinInfo.email := 'test@test.com';

        // 회사조회 권한여부, true-회사조회 / false-개인조회
        joinInfo.searchAllAllowYN := false;

        // 관리자 권한여부, true-관리자 / false-사용자
        joinInfo.mgrYN := false;

        try
                response := htTaxinvoiceService.RegistContact(txtCorpNum.text, joinInfo);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

procedure TTfrmExample.btnListContactClick(Sender: TObject);
var
        InfoList : TContactInfoList;
        tmp : string;
        i : Integer;
begin
        {**********************************************************************}
        { 연동회원의 담당자 목록을 확인합니다.                                 }
        {**********************************************************************}

        try
                InfoList := htTaxinvoiceService.ListContact(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'id(아이디) | email(이메일) | hp(휴대폰) | personName(성명) | searchAllAllowYN(회사조회 권한) | ';
        tmp := tmp + 'tel(연락처) | fax(팩스) | mgrYN(관리자 여부) | regDT(등록일시) | state(상태)' + #13;

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
        { 연동회원의 담당자 정보를 수정합니다.                                 }
        {**********************************************************************}

        contactInfo := TContactInfo.Create;

        // 담당자 아이디
        contactInfo.id := 'testkorea';

        // 담당자명 (최대 100자)
        contactInfo.personName := '테스트 담당자';

        // 연락처 (최대 20자)
        contactInfo.tel := '070-4304-2991';

        // 휴대폰번호 (최대 20자)
        contactInfo.hp := '010-4324-1111';

        // 이메일 주소 (최대 100자)
        contactInfo.email := 'test@test.com';

        // 팩스번호 (최대 20자)
        contactInfo.fax := '02-6442-9799';

        // 조회권한, true(회사조회), false(개인조회)
        contactInfo.searchAllAllowYN := true;

        // 관리자권한 설정여부, true-관리자 / false-사용자
        contactInfo.mgrYN := false;

        try
                response := htTaxinvoiceService.UpdateContact(txtCorpNum.text, contactInfo, txtUserID.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

procedure TTfrmExample.btnGetCorpInfoClick(Sender: TObject);
var
        corpInfo : TCorpInfo;
        tmp : string;
begin
        {**********************************************************************}
        { 연동회원의 회사정보를 확인합니다.                                    }
        {**********************************************************************}

        try
                corpInfo := htTaxinvoiceService.GetCorpInfo(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'CorpName (상호) : ' + corpInfo.CorpName + #13;
        tmp := tmp + 'CeoName (대표자성명) : ' + corpInfo.CeoName + #13;
        tmp := tmp + 'BizType (업태) : ' + corpInfo.BizType + #13;
        tmp := tmp + 'BizClass (종목) : ' + corpInfo.BizClass + #13;
        tmp := tmp + 'Addr (주소) : ' + corpInfo.Addr + #13;
        ShowMessage(tmp);
end;

procedure TTfrmExample.btnUpdateCorpInfoClick(Sender: TObject);
var
        corpInfo : TCorpInfo;
        response : TResponse;
begin
        {**********************************************************************}
        { 연동회원의 회사정보를 수정합니다.                                    }
        {**********************************************************************}

        corpInfo := TCorpInfo.Create;

        // 대표자명, 최대 30자
        corpInfo.ceoname := '대표자명';

        // 상호, 최대 70자
        corpInfo.corpName := '상호';

        // 업태, 최대 40자
        corpInfo.bizType := '업태';

        // 종목, 최대 40자
        corpInfo.bizClass := '종목';

        // 주소, 최대 300자
        corpInfo.addr := '서울특별시 강남구 영동대로 517';

        try
                response := htTaxinvoiceService.UpdateCorpInfo(txtCorpNum.text, corpInfo);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

procedure TTfrmExample.btnRequestJobClick(Sender: TObject);
var
        queryType : EnumQueryType;
        DType : String;
        SDate: String;
        EDate: String;
        jobID: String;
begin
        {************************************************************************}
        { 전자(세금)계산서 매출/매입 내역 수집을 요청합니다.                     }
        {  - 수집 요청시 반환되는 작업아이디(jobID)의 유효시간은 1시간입니다.    }
        {  - 홈택스 연동 프로세스는 "[홈택스연동(전자세금계산서 API 연동매뉴얼 > }
        {     1.1. 홈택스연동(전자세금계산서) API 구성" 을 참고하시기 바랍니다.  }
        {************************************************************************}

        // 전자세금계산서 유형 SELL- 매출, BUY- 매입, TRUSTEE-위수탁
        queryType := SELL;

        // 수집 일자 유형 W-작성일자, I-발행일자, S-전송일자
        DType := 'W';

        // 시작일자, 날자형식(yyyyMMdd)
        SDate := '20180601';

        // 종료일자, 날자형식(yyyyMMdd)
        EDate := '20190201';

        try
                jobID := htTaxinvoiceService.RequestJob(txtCorpNum.text, queryType, DType, SDate, EDate);

        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
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
        { 수집요청에 대한 상태를 확인합니다.                                   }
        { - 응답항목에 관한 정보는 "[[홈택스연동(전자세금계산서 API 연동매뉴얼] }
        {    > 3.1.2. GetJobState(수집 상태 확인)"을 참고 하시기 바랍니다.      }
        {**********************************************************************}

        try
                jobInfo := htTaxinvoiceService.GetJobState(txtCorpNum.text, txtJobId.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        tmp := 'jobID(작업아이디) : '+ jobInfo.jobID + #13;
        tmp := tmp + 'jobState(수집상태) : '+ IntToStr(jobInfo.jobState) + #13;
        tmp := tmp + 'queryType(수집유형) : ' + jobInfo.queryType  + #13;
        tmp := tmp + 'queryDateType(일자유형) : ' + jobInfo.queryDateType  + #13;
        tmp := tmp + 'queryStDate(시작일자) : ' + jobInfo.queryStDate + #13;
        tmp := tmp + 'queryEnDate(종료일자) : ' + jobInfo.queryEnDate + #13;
        tmp := tmp + 'errorCode(오류코드) : ' + IntToStr(jobInfo.errorCode) + #13;
        tmp := tmp + 'errorReason(오류메시지) : ' + jobInfo.errorReason + #13;
        tmp := tmp + 'jobStartDT(작업 시작일시) : ' + jobInfo.jobStartDT + #13;
        tmp := tmp + 'jobEndDT(작업 종료일시) : ' + jobInfo.jobEndDT + #13;
        tmp := tmp + 'collectCount(수집개수) : ' + IntToStr(jobInfo.collectCount) + #13;
        tmp := tmp + 'regDT(수집 요청일시) : ' + jobInfo.regDT + #13 + #13;
        ShowMessage(tmp);
end;

procedure TTfrmExample.btnListActiveJobClick(Sender: TObject);
var
        jobList : THomeTaxTIJobInfoList;
        tmp : String;
        i : Integer;
begin
        {************************************************************************}
        { 1시간 이내 수집 요청한 작업아이디 목록을 확인합니다.                   }
        { - 응답항목에 관한 정보는 "[홈택스연동(전자세금계산서) API 연동매뉴얼]> }
        { 3.1.3. ListActiveJob 수집상태 목록 확인" 을 참조하시기 바랍니다.       }
        {************************************************************************}

        try
                jobList := htTaxinvoiceService.ListActiveState(txtCorpNum.text);

        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        tmp := 'jobID(작업아이디) | jobState(수집상태) | queryType(수집유형) | queryDateType(일자유형) | ';
        tmp := tmp + 'queryStDate(시작일자) |queryEnDate(종료일자) | errorCode(오류코드) | errorReason(오류메시지) | ';
        tmp := tmp + 'jobStartDT(작업 시작일시) | jobEndDT(작업 종료일시) | collectCount(수집개수) | regDT(수집 요청일시) ' + #13;

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
        { 전자(세금)계산서 매출/매입 내역의 수집 결과를 조회합니다.            }
        {  - 수집 요청시 반환되는 작업아이디(jobID)의 유효시간은 1시간입니다.  }
        {**********************************************************************}

        // 문서형태 배열, N - 일반 전자(세금)계산서, M - 수정(전자)세금계산서
        SetLength(docType, 2);
        docType[0] := 'N';
        docType[1] := 'M';

        // 과세형태 배열, T - 과세, N - 면세, Z - 영세
        SetLength(taxType, 3);
        taxType[0] := 'T';
        taxType[1] := 'Z';
        taxType[2] := 'N';

        // 영수/청구 배열, R - 영수, C - 청구, N - 없음
        SetLength(purposeType, 3);
        purposeType[0] := 'R';
        purposeType[1] := 'C';
        purposeType[2] := 'N';

        // 종사업업자번호 사업자 유형, 공백-전체조회, S-공급자, B-공급받는자, T-수탁자
        TaxRegIDType := '';

        // 종사업장번호, 콤마(,)로 구분하여 구성.  ex) '1234,0001'
        TaxRegID := '';

        //종사업장번호 유무,  공백 - 전체조회, 0-종사업장번호 없음, 1-종사업장번호 있음
        TaxRegIDYN := '';

        // 페이지번호
        Page := 1;

        // 페이지당 검색개수
        PerPage := 10;

        // 정렬방향, D-내림차순, A-오름차순
        Order := 'D';

        try
                searchInfo := htTaxinvoiceService.Search(txtCorpNum.text, txtJobId.text,DocType,TaxType, PurposeType, TaxRegIDType, TaxRegID, TaxRegIDYN, Page, PerPage, Order);

        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        tmp := 'code (응답코드) : ' + IntToStr(searchInfo.code) + #13;
        tmp := tmp + 'total (총 검색결과 건수) : ' + IntToStr(searchInfo.total) + #13;
        tmp := tmp + 'perPage (페이지당 검색개수) : ' + IntToStr(searchInfo.perPage) + #13;
        tmp := tmp + 'pageNum (페이지 번호) : ' + IntToStr(searchInfo.pageNum) + #13;
        tmp := tmp + 'pageCount (페이지 개수) : ' + IntToStr(searchInfo.pageCount)+ #13;
        tmp := tmp + 'message (응답 메시지) : ' + searchInfo.message + #13 + #13;

        // 전자(세금)계산서 정보 출력
        //  API호출시 반환되는 추가적인 전자(세금)계산서 항목은
        //  [링크허브]팝빌 -홈택스 전자세금계산서 API 연동매뉴얼 '4.1.1. Search' 를 참조하시기 바랍니다.
        for i := 0 to length(searchInfo.list) - 1 do
        begin
                StringGrid1.Cells[0, i+1] := searchInfo.list[i].ntsconfirmNum;
                StringGrid1.Cells[1, i+1] := searchInfo.list[i].writeDate;
                StringGrid1.Cells[2, i+1] := searchInfo.list[i].issueDate;
                StringGrid1.Cells[3, i+1] := searchInfo.list[i].sendDate;
                StringGrid1.Cells[4, i+1] := searchInfo.list[i].taxType;
                StringGrid1.Cells[5, i+1] := searchInfo.list[i].purposeType;
                StringGrid1.Cells[6, i+1] := searchInfo.list[i].supplyCostTotal;
                StringGrid1.Cells[7, i+1] := searchInfo.list[i].taxTotal;
                StringGrid1.Cells[8, i+1] := searchInfo.list[i].totalAmount;
                StringGrid1.Cells[9, i+1] := searchInfo.list[i].remark1;
                StringGrid1.Cells[10, i+1] := searchInfo.list[i].invoiceType;
                if searchInfo.list[i].modifyYN then
                begin
                        StringGrid1.Cells[11, i+1] := '수정';
                end
                else
                        StringGrid1.Cells[11, i+1] := '일반';
                StringGrid1.Cells[12, i+1] := searchInfo.list[i].orgNTSConfirmNum;
                StringGrid1.Cells[13, i+1] := searchInfo.list[i].purchaseDate;
                StringGrid1.Cells[14, i+1] := searchInfo.list[i].itemName;
                StringGrid1.Cells[15, i+1] := searchInfo.list[i].spec;
                StringGrid1.Cells[16, i+1] := searchInfo.list[i].qty;
                StringGrid1.Cells[17, i+1] := searchInfo.list[i].unitCost;
                StringGrid1.Cells[18, i+1] := searchInfo.list[i].supplyCost;
                StringGrid1.Cells[19, i+1] := searchInfo.list[i].tax;
                StringGrid1.Cells[20, i+1] := searchInfo.list[i].remark;
                StringGrid1.Cells[21, i+1] := searchInfo.list[i].invoicerCorpNum;
                StringGrid1.Cells[22, i+1] := searchInfo.list[i].invoicerTaxRegID;
                StringGrid1.Cells[23, i+1] := searchInfo.list[i].invoicerCorpName;
                StringGrid1.Cells[24, i+1] := searchInfo.list[i].invoicerCEOName;
                StringGrid1.Cells[25, i+1] := searchInfo.list[i].invoicerEmail;
                StringGrid1.Cells[26, i+1] := searchInfo.list[i].invoiceeCorpNum;
                StringGrid1.Cells[27, i+1] := searchInfo.list[i].invoiceeType;
                StringGrid1.Cells[28, i+1] := searchInfo.list[i].invoiceeTaxRegID;
                StringGrid1.Cells[29, i+1] := searchInfo.list[i].invoiceeCorpName;
                StringGrid1.Cells[30, i+1] := searchInfo.list[i].invoiceeCEOName;
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
        {************************************************************************}
        { 전자(세금)계산서 매출/매입 내역의 수집 결과 요약정보를 조회합니다.     }
        {  - 수집 요청시 반환되는 작업아이디(jobID)의 유효시간은 1시간입니다.    }
        {  - 응답항목에 관한 정보는 "[홈택스연동(전자세금계산서) API 연동매뉴얼] }
        {     > 3.2.2. Summary 수집 결과 요약정보 조회" 을 참조하시기 바랍니다.  }
        {************************************************************************}

        // 문서형태 배열, N - 일반 전자(세금)계산서, M - 수정(전자)세금계산서
        SetLength(docType, 2);
        docType[0] := 'N';
        docType[1] := 'M';

        // 과세형태 배열, T - 과세, N - 면세, Z - 영세
        SetLength(taxType, 3);
        taxType[0] := 'T';
        taxType[1] := 'Z';
        taxType[2] := 'N';

        // 영수/청구 배열, R - 영수, C - 청구, N - 없음
        SetLength(purposeType, 3);
        purposeType[0] := 'R';
        purposeType[1] := 'C';
        purposeType[2] := 'N';

        // 종사업업자번호 사업자 유형, S-공급자, B-공급받는자, T-수탁자
        TaxRegIDType := 'S';

        // 종사업장번호, 콤마(,)로 구분하여 구성 ex)0001,0007
        taxRegID := '';

        //종사업장번호 유무, 공백 - 전체조회, 0-종사업장번호 없음, 1-종사업장번호 있음
        TaxRegIDYN := '';

        try
                summaryInfo := htTaxinvoiceService.Summary(txtCorpNum.text, txtJobId.text,DocType,TaxType, PurposeType, TaxRegIDType, TaxRegID, TaxRegIDYN);

        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        tmp := 'count (수집 결과 건수) : ' + IntToStr(summaryInfo.count) + #13;
        tmp := tmp + 'supplyCostTotal (공급가액 합계) : ' + IntToStr(summaryInfo.supplyCostTotal) + #13;
        tmp := tmp + 'taxTotal (세액 합계) : ' + IntToStr(summaryInfo.taxTotal) + #13;
        tmp := tmp + 'amountTotal (합계 금액) : ' + IntToStr(summaryInfo.amountTotal) + #13;
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
        { 1건의 전자(세금)계산서 상세정보를 조회합니다.                        }
        {  - 응답항목에 대한 정보는 "[API 연동매뉴얼] > 4.1.2. GetTaxinvoice   }
        {    상세정보 확인 - JSON" 을 참조하시기 바랍니다.                     }
        {**********************************************************************}

        ntsConfirmNum := txtntsconfirmNum.Text;

        try
                taxinvoice := htTaxinvoiceService.getTaxinvoice(txtCorpNum.text,ntsConfirmNum);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        tmp := tmp + 'writeDate (작성일자) : ' + taxinvoice.writeDate + #13;
        tmp := tmp + 'issueDT (발행일시) : ' + taxinvoice.issueDT + #13;
        tmp := tmp + 'invoiceType (전자세금계산서 종류) : ' + IntToStr(taxinvoice.invoiceType) + #13;
        tmp := tmp + 'taxType (과세형태) : ' + taxinvoice.taxType + #13;
        tmp := tmp + 'supplyCostTotal (공급가액 합계) : ' + taxinvoice.supplyCostTotal + #13;
        tmp := tmp + 'taxTotal (세액합계) : ' + taxinvoice.taxTotal + #13;
        tmp := tmp + 'totalAmount (합계금액) : ' + taxinvoice.totalAmount + #13;
        tmp := tmp + 'purposeType (영수/청구) : ' + taxinvoice.purposeType + #13;
        tmp := tmp + 'cash (현금) : ' + taxinvoice.cash + #13;
        tmp := tmp + 'chkBill (수표) : ' + taxinvoice.chkBill + #13;
        tmp := tmp + 'credit (외상) : ' + taxinvoice.credit + #13;
        tmp := tmp + 'note (어음) : ' + taxinvoice.note + #13;
        tmp := tmp + 'remark1 (비고1) : ' + taxinvoice.remark1 + #13;
        tmp := tmp + 'remark2 (비고2) : ' + taxinvoice.remark2 + #13;
        tmp := tmp + 'remark3 (비고3) : ' + taxinvoice.remark3 + #13;
        tmp := tmp + 'ntsconfirmNum (국세청승인번호) : ' + taxinvoice.ntsconfirmNum + #13;
        tmp := tmp + 'modifyCode (수정사유코드) : ' + IntToStr(taxinvoice.modifyCode) + #13;
        tmp := tmp + 'orgNTSConfirmNum (원본 전자세금계산서 국세청 승인번호) : ' + taxinvoice.orgNTSConfirmNum + #13 +#13;

        tmp := tmp + '========전자(세금)계산서 공급자 정보========' +#13;
        tmp := tmp + 'invoicerCorpNum (공급자 사업자번호) : ' + taxinvoice.invoicerCorpNum +#13;
        tmp := tmp + 'invoicerMgtKey (공급자 문서관리번호) : ' + taxinvoice.invoicerMgtKey +#13;
        tmp := tmp + 'invoicerTaxRegID (공급자 종사업장번호) : ' + taxinvoice.invoicerTaxRegID +#13;
        tmp := tmp + 'invoicerCorpName (공급자 상호) : ' + taxinvoice.invoicerCorpName +#13;
        tmp := tmp + 'invoicerCEOName (공급자 대표자 성명) : ' + taxinvoice.invoicerCEOName +#13;
        tmp := tmp + 'invoicerAddr (공급자 주소) : ' + taxinvoice.invoicerAddr +#13;
        tmp := tmp + 'invoicerBizType (공급자 업태) : ' + taxinvoice.invoicerBizType +#13;
        tmp := tmp + 'invoicerBizClass (공급자 종목) : ' + taxinvoice.invoicerBizClass +#13;
        tmp := tmp + 'invoicerContactName (공급자 담당자 성명) : ' + taxinvoice.invoicerContactName +#13;
        tmp := tmp + 'invoicerTEL (공급자 담당자 연락처) : ' + taxinvoice.invoicerTEL +#13;
        tmp := tmp + 'invoicerEmail (공급자 이메일) : ' + taxinvoice.invoicerEmail +#13 +#13;

        tmp := tmp + '=========전자(세금)계산서 공급받는자 정보=========' +#13;
        tmp := tmp + 'invoiceeCorpNum (공급받는자 사업자번호) : ' + taxinvoice.invoiceeCorpNum +#13;
        tmp := tmp + 'invoiceeType (공급받는자 구분) : ' + taxinvoice.invoiceeType +#13;
        tmp := tmp + 'invoiceeTaxRegID (공급받는자 종사업자번호) : ' + taxinvoice.invoiceeTaxRegID +#13;
        tmp := tmp + 'invoiceeCorpName (공급받는자 상호) : ' + taxinvoice.invoiceeCorpName +#13;
        tmp := tmp + 'invoiceeCEOName (공급받는자 대표자 성명) : ' + taxinvoice.invoiceeCEOName +#13;
        tmp := tmp + 'invoiceeAddr (공급받는자 주소) : ' + taxinvoice.invoiceeAddr +#13;
        tmp := tmp + 'invoiceeBizType (공급받는자 업태) : ' + taxinvoice.invoiceeBizType +#13;
        tmp := tmp + 'invoiceeBizClass (공급받는자 종목) : ' + taxinvoice.invoiceeBizClass +#13;
        tmp := tmp + 'invoiceeContactName1 (공급받는자 담당자 성명) : ' + taxinvoice.invoiceeContactName1 +#13;
        tmp := tmp + 'invoiceeTEL1 (공급받는자 담당자 연락처) : ' + taxinvoice.invoiceeTEL1 +#13;
        tmp := tmp + 'invoiceeEmail1 (공급받는자 이메일) : ' + taxinvoice.invoiceeEmail1 +#13 +#13;

        tmp := tmp + '========상세항목========' + #13;
        tmp := tmp + 'serialNum(일련번호) | purchaseDT(거래일자) | itemName(품명) | spec(규격) | qty(수량) |';
        tmp := tmp + 'unitCost(단가) | supplyCost(공급가액) | tax(세액) | remark(비고)' + #13;

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
        { 1건의 전자(세금)계산서 상세정보를 조회합니다. (XML형식)              }
        {  - 응답항목에 대한 정보는 "홈택스연동(전자세금계산서 API 연동매뉴얼] }
        {    3.2.4. GetXML(상세정보 확인 - XML)" 을 참고하시기 바랍니다.       }
        {*************************************"********************************}

        ntsConfirmNum := txtntsconfirmNum.Text;

        try
                response := htTaxinvoiceService.getXML(txtCorpNum.text,ntsConfirmNum);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        tmp := 'ResultCode (요청에 대한 응답 상태코드) : ' + IntToStr(response.ResultCode) + #13;
        tmp := tmp + 'Message (국세청승인번호) : ' + response.Message + #13;
        tmp := tmp + 'retObject (XML문서) : ' + #13 + response.retObject;
        ShowMessage(tmp);
end;

procedure TTfrmExample.btnGetCertificatePopUpURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        { 홈택스 연동 인증관리를 위한 URL을 반환 합니다.                       }
        { - 인증방식에는 부서사용자/공인인증서 인증 방식이 있습니다.           }
        { - URL 보안정책에 따라 반환된 URL은 30초의 유효시간을 갖습니다.       }
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.GetCertificatePopUpURL(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
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
        { 정액제 서비스 신청 팝업 URL을 반환합니다.                            }
        { - URL 보안정책에 따라 반환된 URL은 30초의 유효시간을 갖습니다.       }
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.GetFlatRatePopUpURL(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
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
        { 팝빌에 등록된 홈택스 공인인증서 만료일자를 확인합니다.               }
        {**********************************************************************}

        try
                expires := htTaxinvoiceService.GetCertificateExpireDate(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
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
        { 정액제 서비스 상태를 확인합니다.                                     }
        {**********************************************************************}

        try
                stateInfo := htTaxinvoiceService.GetFlatRateState(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        tmp := 'referenceID (사업자번호) : ' + stateInfo.referenceID + #13;
        tmp := tmp + 'contractDT (정액제 서비스 시작일시) : ' + stateInfo.contractDT + #13;
        tmp := tmp + 'useEndDate (정액제 서비스 종료일시) : ' + stateInfo.useEndDate + #13;
        tmp := tmp + 'baseDate (자동연장 결제일) : ' + IntToStr(stateInfo.baseDate) + #13;
        tmp := tmp + 'state (정액제 서비스 상태) : ' + IntToStr(stateInfo.state) + #13;
        tmp := tmp + 'closeRequestYN (정액제 해지신청 여부) : ' + BoolToStr(stateInfo.closeRequestYN) + #13;
        tmp := tmp + 'useRestrictYN (정액제 사용제한 여부) : ' + BoolToStr(stateInfo.useRestrictYN) + #13;
        tmp := tmp + 'closeOnExpired (정액제 만료시 해지 여부) : ' + BoolToStr(stateInfo.closeOnExpired) + #13;
        tmp := tmp + 'unPaidYN (미수금 보유 여부) : ' + BoolToStr(stateInfo.unPaidYN) + #13;
        ShowMessage(tmp);
end;

procedure TTfrmExample.btnGetChargeInfoClick(Sender: TObject);
var
        chargeInfo : THometaxTIChargeInfo;
        tmp : String;
begin
        {**********************************************************************}
        { 홈택스 전자세금계산서 연동  API 서비스 과금정보를 확인합니다.        }
        {**********************************************************************}

        try
                chargeInfo := htTaxinvoiceService.GetChargeInfo(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        tmp := 'unitCost (단가) : ' + chargeInfo.unitCost + #13;
        tmp := tmp + 'chargeMethod (과금유형) : ' + chargeInfo.chargeMethod + #13;
        tmp := tmp + 'rateSystem (과금제도) : ' + chargeInfo.rateSystem + #13;
        ShowMessage(tmp);
end;

procedure TTfrmExample.btnGetAccessURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        {    팝빌(www.popbill.com)에 로그인된 팝업 URL을 반환합니다.           }
        {    URL 보안정책에 따라 반환된 URL은 30초의 유효시간을 갖습니다.      }
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.getAccessURL(txtCorpNum.Text, txtUserID.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('팝빌 로그인 URL' + #13 + resultURL);
end;

procedure TTfrmExample.btnGetChargeURLClick(Sender: TObject);
var
  resultURL : String;
begin
        {**********************************************************************}
        {    연동회원 포인트 충전 URL을 반환합니다.                            }
        {    URL 보안정책에 따라 반환된 URL은 30초의 유효시간을 갖습니다.      }
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.getChargeURL(txtCorpNum.Text, txtUserID.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('포인트충전 URL ' + #13 + resultURL);
end;

procedure TTfrmExample.btnGetPartnerURL_CHRGClick(Sender: TObject);
var
  resultURL : String;
begin
        {**********************************************************************}
        {    파트너 포인트 충전 URL을 반환합니다.                              }
        {    URL 보안정책에 따라 반환된 URL은 30초의 유효시간을 갖습니다.      }
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.getPartnerURL(txtCorpNum.Text, 'CHRG');
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('파트너 포인트충전 URL ' + #13 + resultURL);
end;

procedure TTfrmExample.btnGetPopUpURLClick(Sender: TObject);
var
  resultURL, NTSConfirmNum : String;
begin
        {**********************************************************************}
        {    홈택스 전자세금계산서 보기 팝업 URL을 반환한다.                   }
        {    URL 보안정책에 따라 반환된 URL은 30초의 유효시간을 갖습니다.      }
        {**********************************************************************}

        NTSConfirmNum := txtntsconfirmNum.text;

        try
                resultURL := htTaxinvoiceService.getPopUpURL(txtCorpNum.Text, NTSConfirmNum);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('홈택스 전자세금계산서 보기 팝업 URL ' + #13 + resultURL);
end;

procedure TTfrmExample.btnCheckCertValidationClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 팝빌에 등록된 공인인증서의 홈택스 로그인을 테스트한다.               }
        {**********************************************************************}

        try
                response := htTaxinvoiceService.CheckCertValidation(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

procedure TTfrmExample.btnRegistDeptUserClick(Sender: TObject);
var
        response : TResponse;
        deptUserID, deptUserPWD : String;
begin
        {**********************************************************************}
        { 홈택스 전자세금계산서 부서사용자 계정을 등록한다.                    }
        {**********************************************************************}

        //홈택스에서 생성한 전자세금계산서 부서사용자 아이디
        deptUserID := 'userid_test';

        // 홈택스에서 생성한 전자세금계산서 부서사용자 비밀번호
        deptUserPWD := 'userpwd_test';

        try
                response := htTaxinvoiceService.RegistDeptUser(txtCorpNum.Text, deptUserID, deptUserPWD);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

procedure TTfrmExample.btnCheckDeptUserClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 팝빌에 등록된 전자세금계산서 부서사용자 아이디를 확인한다.           }
        {**********************************************************************}

        try
                response := htTaxinvoiceService.CheckDeptUser(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

procedure TTfrmExample.btnCheckLoginDeptUserClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 팝빌에 등록된 전자세금계산서 부서사용자 계정정보를 이용하여          }
        { 홈택스 로그인을 테스트한다.                                          }
        {**********************************************************************}

        try
                response := htTaxinvoiceService.CheckLoginDeptUser(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

procedure TTfrmExample.btnDeleteDeptUserClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 팝빌에 등록된 전자세금계산서 부서사용자 계정정보를 삭제한다.         }
        {**********************************************************************}

        try
                response := htTaxinvoiceService.DeleteDeptUser(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
end;

end.
