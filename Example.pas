{******************************************************************************}
{
{ 팝빌 홈택스 전자세금계산서 API Delphi SDK Example
{ Delphi 연동 튜토리얼 안내 : https://developers.popbill.com/guide/httaxinvoice/delphi/getting-started/tutorial
{
{ 업데이트 일자 : 2024-02-27
{ 연동기술지원 연락처 : 1600-9854
{ 연동기술지원 이메일 : code@linkhubcorp.com
{
{ <테스트 연동개발 준비사항>
{ 1) API Key 변경 (연동신청 시 메일로 전달된 정보)
{     - LinkID : 링크허브에서 발급한 링크아이디
{     - SecretKey : 링크허브에서 발급한 비밀키
{ 2) SDK 환경설정 옵션 설정
{    - IsTest : 연동환경 설정, true-테스트, false-운영(Production), (기본값:true)
{    - IsThrowException : 예외 처리 설정, true-사용, false-미사용, (기본값:true)
{    - IPRestrictOnOff : 인증토큰 IP 검증 설정, true-사용, false-미사용, (기본값:true)
{    - UseLocalTimeYN : 로컬시스템 시간 사용여부, true-사용, false-미사용, (기본값:true)
{ 3) 홈택스 로그인 인증정보를 등록합니다. (부서사용자등록 / 공동인증서 등록)
{    - 팝빌로그인 > [홈택스연동] > [환경설정] > [인증 관리] 메뉴
{    - 홈택스연동 인증 관리 팝업 URL(GetCertificatePopUpURL API) 반환된 URL을 이용하여
{      홈택스 인증 처리를 합니다.
{
{******************************************************************************}

unit Example;

interface

uses
Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, TypInfo,
  Popbill, PopbillHTTaxinvoice, ExtCtrls, Grids;

const

        // 링크아이디
        LinkID = 'TESTER';

        // 비밀키
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
    btnGetPrintURL: TButton;
    btnGetPaymentURL: TButton;
    btnGetUseHistoryURL: TButton;
    btnGetContactInfo: TButton;
    txtURL: TEdit;
    Label5: TLabel;
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
    procedure btnGetPrintURLClick(Sender: TObject);
    procedure btnGetPaymentURLClick(Sender: TObject);
    procedure btnGetUseHistoryURLClick(Sender: TObject);
    procedure btnGetContactInfoClick(Sender: TObject);
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
        // 홈택스 세금계산서 모듈 초기화
        htTaxinvoiceService := THometaxTIService.Create(LinkID,SecretKey);

        // 연동환경 설정, true-테스트, false-운영(Production), (기본값:true)
        htTaxinvoiceService.IsTest := true;

        // 예외 처리 설정, true-사용, false-미사용, (기본값:true)
        htTaxinvoiceService.IsThrowException := true;

        // 인증토큰 IP 검증 설정, true-사용, false-미사용, (기본값:true)
        htTaxinvoiceService.IPRestrictOnOff := true;

        // 로컬시스템 시간 사용여부, true-사용, false-미사용, (기본값:true)
        htTaxinvoiceService.UseLocalTimeYN := false;

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
        StringGrid1.Cells[31,0] := 'invoiceeEmail1';
        StringGrid1.Cells[32,0] := 'invoiceeEmail2';
        StringGrid1.Cells[33,0] := 'trusteeCorpNum';
        StringGrid1.Cells[34,0] := 'trusteeTaxRegID';
        StringGrid1.Cells[35,0] := 'trusteeCorpName';
        StringGrid1.Cells[36,0] := 'trusteeCEOName';
        StringGrid1.Cells[37,0] := 'trusteeEmail';
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
        { 사업자번호를 조회하여 연동회원 가입여부를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/member#CheckIsMember
        {**********************************************************************}

        try
                response := htTaxinvoiceService.CheckIsMember(txtCorpNum.text, LinkID);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;
end;

procedure TTfrmExample.btnCheckIDClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 사용하고자 하는 아이디의 중복여부를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/member#CheckID
        {**********************************************************************}

        try
                response := htTaxinvoiceService.CheckID(txtUserID.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;
end;

procedure TTfrmExample.btnJoinMemberClick(Sender: TObject);
var
        response : TResponse;
        joinInfo : TJoinForm;
begin
        {**********************************************************************}
        { 사용자를 연동회원으로 가입처리합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/member#JoinMember
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

        // 비밀번호 (8자 이상 20자 미만) 영문, 숫자 ,특수문자 조합
        joinInfo.Password := 'asdf123!@';

        // 담당자명, 최대 100자
        joinInfo.ContactName := '담당자명';

        // 담당자 연락처, 최대 20자
        joinInfo.ContactTEL :='070-4304-2991';

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
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;

end;

procedure TTfrmExample.btnGetBalanceClick(Sender: TObject);
var
        balance : Double;
begin
        {**********************************************************************}
        { 연동회원의 잔여포인트를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/point#GetBalance  
        {**********************************************************************}

        try
                balance := htTaxinvoiceService.GetBalance(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('잔여포인트 : ' + FloatToStr(balance));
        end;
end;

procedure TTfrmExample.btnGetPartnerBalanceClick(Sender: TObject);
var
        balance : Double;
begin
        {**********************************************************************}
        { 파트너의 잔여포인트를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/point#GetPartnerBalance
        {**********************************************************************}

        try
                balance := htTaxinvoiceService.GetPartnerBalance(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('잔여포인트 : ' + FloatToStr(balance));
        end;

end;

procedure TTfrmExample.btnRegistContactClick(Sender: TObject);
var
        response : TResponse;
        joinInfo : TJoinContact;
begin
        {**********************************************************************}
        { 연동회원 사업자번호에 담당자(팝빌 로그인 계정)를 추가합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/member#RegistContact
        {**********************************************************************}

        // [필수] 담당자 아이디 (6자 이상 50자 미만)
        joinInfo.id := 'testkorea';

        // 비밀번호 (8자 이상 20자 미만) 영문, 숫자 ,특수문자 조합
        joinInfo.Password := 'asdf123!@';

        // [필수] 담당자명(한글이나 영문 100자 이내)
        joinInfo.personName := '담당자성명';

        // [필수] 연락처 (최대 20자)
        joinInfo.tel := '070-4304-2991';

        // [필수] 이메일 (최대 100자)
        joinInfo.email := 'test@test.com';
        
        // 담당자 권한, 1-개인권한 / 2-읽기권한 / 3-회사권한
        joinInfo.searchRole := '3';

        try
                response := htTaxinvoiceService.RegistContact(txtCorpNum.text, joinInfo);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;

end;

procedure TTfrmExample.btnListContactClick(Sender: TObject);
var
        InfoList : TContactInfoList;
        tmp : string;
        i : Integer;
begin
        {**********************************************************************}
        { 연동회원 사업자번호에 등록된 담당자(팝빌 로그인 계정) 목록을 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/member#ListContact
        {**********************************************************************}

        try
                InfoList := htTaxinvoiceService.ListContact(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                tmp := 'id(아이디) | email(이메일) | personName(성명) | searchRole(담당자 권한) | ';
                tmp := tmp + 'tel(연락처) | mgrYN(관리자 여부) | regDT(등록일시) | state(상태)' + #13;

                for i := 0 to Length(InfoList) -1 do
                begin
                    tmp := tmp + InfoList[i].id + ' | ';
                    tmp := tmp + InfoList[i].email + ' | ';
                    tmp := tmp + InfoList[i].personName + ' | ';
                    tmp := tmp + InfoList[i].searchRole + ' | ';
                    tmp := tmp + InfoList[i].tel + ' | ';
                    tmp := tmp + BoolToStr(InfoList[i].mgrYN) + ' | ';
                    tmp := tmp + InfoList[i].regDT + ' | ';
                    tmp := tmp + IntToStr(InfoList[i].state) + #13;
                end;
                ShowMessage(tmp);
        end;
end;

procedure TTfrmExample.btnUpdateContactClick(Sender: TObject);
var
        contactInfo : TContactInfo;
        response : TResponse;
begin
        {**********************************************************************}
        { 연동회원 사업자번호에 등록된 담당자(팝빌 로그인 계정) 정보를 수정합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/member#UpdateContact
        {**********************************************************************}

        contactInfo := TContactInfo.Create;

        // 담당자 아이디
        contactInfo.id := 'testkorea';

        // 담당자명 (최대 100자)
        contactInfo.personName := '테스트 담당자';

        // 연락처 (최대 20자)
        contactInfo.tel := '070-4304-2991';

        // 이메일 주소 (최대 100자)
        contactInfo.email := 'test@test.com';

        // 담당자 권한, 1-개인권한 / 2-읽기권한 / 3-회사권한
        contactInfo.searchRole := '3';

        try
                response := htTaxinvoiceService.UpdateContact(txtCorpNum.text, contactInfo, txtUserID.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;

end;

procedure TTfrmExample.btnGetCorpInfoClick(Sender: TObject);
var
        corpInfo : TCorpInfo;
        tmp : string;
begin
        {**********************************************************************}
        { 연동회원의 회사정보를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/member#GetCorpInfo
        {**********************************************************************}

        try
                corpInfo := htTaxinvoiceService.GetCorpInfo(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                tmp := 'CorpName (상호) : ' + corpInfo.CorpName + #13;
                tmp := tmp + 'CeoName (대표자성명) : ' + corpInfo.CeoName + #13;
                tmp := tmp + 'BizType (업태) : ' + corpInfo.BizType + #13;
                tmp := tmp + 'BizClass (종목) : ' + corpInfo.BizClass + #13;
                tmp := tmp + 'Addr (주소) : ' + corpInfo.Addr + #13;
                ShowMessage(tmp);
        end;

end;

procedure TTfrmExample.btnUpdateCorpInfoClick(Sender: TObject);
var
        corpInfo : TCorpInfo;
        response : TResponse;
begin
        {**********************************************************************}
        { 연동회원의 회사정보를 수정합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/member#UpdateCorpInfo
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
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;

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
        { 홈택스에 신고된 전자세금계산서 매입/매출 내역 수집을 팝빌에 요청합니다. (조회기간 단위 : 최대 3개월)
        { - 주기적으로 자체 DB에 세금계산서 정보를 INSERT 하는 경우, 조회할 일자 유형(DType) 값을 "S"로 하는 것을 권장합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/job#RequestJob
        {**********************************************************************}

        // 전자세금계산서 유형 SELL- 매출, BUY- 매입, TRUSTEE-위수탁
        queryType := SELL;

        // 수집 일자 유형 W-작성일자, I-발행일자, S-전송일자
        DType := 'S';

        // 시작일자, 날자형식(yyyyMMdd)
        SDate := '20220101';

        // 종료일자, 날자형식(yyyyMMdd)
        EDate := '20220110';

        try
                jobID := htTaxinvoiceService.RequestJob(txtCorpNum.text, queryType, DType, SDate, EDate);

        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('jobID : ' + jobID);
                txtjobID.text := jobID;
        end;

end;

procedure TTfrmExample.btnGetJobStateClick(Sender: TObject);
var
        jobInfo : THomeTaxTIJobInfo;
        tmp : String;
begin
        {**********************************************************************}
        { 수집 요청(RequestJob API) 함수를 통해 반환 받은 작업 아이디의 상태를 확인합니다.
        { - 수집 결과 조회(Search API) 함수 또는 수집 결과 요약 정보 조회(Summary API) 함수를 사용하기 전에
        {   수집 작업의 진행 상태, 수집 작업의 성공 여부를 확인해야 합니다.
        { - 작업 상태(jobState) = 3(완료)이고 수집 결과 코드(errorCode) = 1(수집성공)이면
        {   수집 결과 내역 조회(Search) 또는 수집 결과 요약 정보 조회(Summary)를 해야합니다.
        { - 작업 상태(jobState)가 3(완료)이지만 수집 결과 코드(errorCode)가 1(수집성공)이 아닌 경우에는
        {   오류메시지(errorReason)로 수집 실패에 대한 원인을 파악할 수 있습니다.                                
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/job#GetJobState
        {**********************************************************************}

        try
                jobInfo := htTaxinvoiceService.GetJobState(txtCorpNum.text, txtJobId.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
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

end;

procedure TTfrmExample.btnListActiveJobClick(Sender: TObject);
var
        jobList : THomeTaxTIJobInfoList;
        tmp : String;
        i : Integer;
begin
        {**********************************************************************}
        { 전자세금계산서 매입/매출 내역 수집요청에 대한 상태 목록을 확인합니다.
        { - 수집 요청 후 1시간이 경과한 수집 요청건은 상태정보가 반환되지 않습니다.                
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/job#ListActiveJob
        {**********************************************************************}

        try
                jobList := htTaxinvoiceService.ListActiveState(txtCorpNum.text);

        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin

                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin        
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
        searchString : string;

begin
        {**********************************************************************}
        { 수집 상태 확인(GetJobState API) 함수를 통해 상태 정보가 확인된 작업아이디를 활용하여 수집된 전자세금계산서 매입/매출 내역을 조회합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/search#Search
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
        
        // 조회 검색어, 거래처 사업자번호 또는 거래처명 like 검색
        SearchString := '';

        try
                searchInfo := htTaxinvoiceService.Search(txtCorpNum.text, txtJobId.text,DocType,TaxType, PurposeType, TaxRegIDType, TaxRegID, TaxRegIDYN, Page, PerPage, Order, txtUserID.text, SearchString);

        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;


        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
                exit;
        end
        else
        begin

                tmp := 'code (응답코드) : ' + IntToStr(searchInfo.code) + #13;
                tmp := tmp + 'total (총 검색결과 건수) : ' + IntToStr(searchInfo.total) + #13;
                tmp := tmp + 'perPage (페이지당 검색개수) : ' + IntToStr(searchInfo.perPage) + #13;
                tmp := tmp + 'pageNum (페이지 번호) : ' + IntToStr(searchInfo.pageNum) + #13;
                tmp := tmp + 'pageCount (페이지 개수) : ' + IntToStr(searchInfo.pageCount)+ #13;
                tmp := tmp + 'message (응답 메시지) : ' + searchInfo.message + #13 + #13;

                // 전자(세금)계산서 정보 출력
                for i := 0 to length(searchInfo.list) - 1 do
                begin
                        StringGrid1.Cells[0, i+1] := searchInfo.list[i].ntsconfirmNum;   // 국세청 승인번호
                        StringGrid1.Cells[1, i+1] := searchInfo.list[i].writeDate;       // 작성일자
                        StringGrid1.Cells[2, i+1] := searchInfo.list[i].issueDate;       // 발행일자
                        StringGrid1.Cells[3, i+1] := searchInfo.list[i].sendDate;        // 전송일자
                        StringGrid1.Cells[4, i+1] := searchInfo.list[i].taxType;         // 과세형태
                        StringGrid1.Cells[5, i+1] := searchInfo.list[i].purposeType;     // 영수/청구
                        StringGrid1.Cells[6, i+1] := searchInfo.list[i].supplyCostTotal; // 공급가액 합계
                        StringGrid1.Cells[7, i+1] := searchInfo.list[i].taxTotal;        // 세액 합계
                        StringGrid1.Cells[8, i+1] := searchInfo.list[i].totalAmount;     // 합계금액
                        StringGrid1.Cells[9, i+1] := searchInfo.list[i].remark1;         // 비고
                        StringGrid1.Cells[10, i+1] := searchInfo.list[i].invoiceType;    // 매입/매출

                        if searchInfo.list[i].modifyYN then                              // 수정 전자세금계산서 여부
                        begin
                                StringGrid1.Cells[11, i+1] := '수정';
                        end
                        else
                                StringGrid1.Cells[11, i+1] := '일반';
                        StringGrid1.Cells[12, i+1] := searchInfo.list[i].orgNTSConfirmNum; // 원본 전자세금계산서 국세청 승인번호
                        StringGrid1.Cells[13, i+1] := searchInfo.list[i].purchaseDate;     // 거래일자
                        StringGrid1.Cells[14, i+1] := searchInfo.list[i].itemName;         // 품명
                        StringGrid1.Cells[15, i+1] := searchInfo.list[i].spec;             // 규격
                        StringGrid1.Cells[16, i+1] := searchInfo.list[i].qty;              // 수량
                        StringGrid1.Cells[17, i+1] := searchInfo.list[i].unitCost;         // 단가
                        StringGrid1.Cells[18, i+1] := searchInfo.list[i].supplyCost;       // 공급가액
                        StringGrid1.Cells[19, i+1] := searchInfo.list[i].tax;              // 세액
                        StringGrid1.Cells[20, i+1] := searchInfo.list[i].remark;           // 비고
                        StringGrid1.Cells[21, i+1] := searchInfo.list[i].invoicerCorpNum;  // 공급자 사업자번호
                        StringGrid1.Cells[22, i+1] := searchInfo.list[i].invoicerTaxRegID; // 공급자 종사업장번호
                        StringGrid1.Cells[23, i+1] := searchInfo.list[i].invoicerCorpName; // 공급자 상호
                        StringGrid1.Cells[24, i+1] := searchInfo.list[i].invoicerCEOName;  // 공급자 대표자 성명
                        StringGrid1.Cells[25, i+1] := searchInfo.list[i].invoicerEmail;    // 공급자 담당자 이메일
                        StringGrid1.Cells[26, i+1] := searchInfo.list[i].invoiceeCorpNum;  // 공급받는자 사업자번호
                        StringGrid1.Cells[27, i+1] := searchInfo.list[i].invoiceeType;     // 공급받는자 구분
                        StringGrid1.Cells[28, i+1] := searchInfo.list[i].invoiceeTaxRegID; // 공급받는자 종사업장번호
                        StringGrid1.Cells[29, i+1] := searchInfo.list[i].invoiceeCorpName; // 공급받는자 상호
                        StringGrid1.Cells[30, i+1] := searchInfo.list[i].invoiceeCEOName;  // 공급받는자 대표자 성명
                        StringGrid1.Cells[31, i+1] := searchInfo.list[i].invoiceeEmail1;   // 공급받는자 담당자 이메일
                        StringGrid1.Cells[32, i+1] := searchInfo.list[i].invoiceeEmail2;   // ASP 연계사업자 메일
                        StringGrid1.Cells[33, i+1] := searchInfo.list[i].trusteeCorpNum;   // 수탁자 사업자번호
                        StringGrid1.Cells[34, i+1] := searchInfo.list[i].trusteeTaxRegID;  // 수탁자 종사업장번호
                        StringGrid1.Cells[35, i+1] := searchInfo.list[i].trusteeCorpName;  // 수탁자 상호
                        StringGrid1.Cells[36, i+1] := searchInfo.list[i].trusteeCEOName;   // 수탁자 대표자 성명
                        StringGrid1.Cells[37, i+1] := searchInfo.list[i].trusteeEmail;     // 수탁자 담당자 이메일
                end;
                ShowMessage(tmp);
        end;
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
        searchString : string;
begin
        {**********************************************************************}
        { 수집 상태 확인(GetJobState API) 함수를 통해 상태 정보가 확인된 작업아이디를 활용하여 수집된 전자세금계산서 매입/매출 내역의 요약 정보를 조회합니다.
        { - 요약 정보 : 전자세금계산서 수집 건수, 공급가액 합계, 세액 합계, 합계 금액  
        {  - https://developers.popbill.com/reference/httaxinvoice/delphi/api/search#Summary
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

        // 종사업업자번호 사업자 유형, S-공급자, B-공급받는자, T-수탁자
        TaxRegIDType := 'S';

        // 종사업장번호, 콤마(,)로 구분하여 구성 ex)0001,0007
        taxRegID := '';

        //종사업장번호 유무, 공백 - 전체조회, 0-종사업장번호 없음, 1-종사업장번호 있음
        TaxRegIDYN := '';

        // 조회 검색어, 거래처 사업자번호 또는 거래처명 like 검색
        SearchString := '';
                
        try
                summaryInfo := htTaxinvoiceService.Summary(txtCorpNum.text, txtJobId.text,DocType,TaxType, PurposeType, TaxRegIDType, TaxRegID, TaxRegIDYN, txtUserID.text, SearchString);

        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
                exit;
        end
        else
        begin
                tmp := 'count (수집 결과 건수) : ' + IntToStr(summaryInfo.count) + #13;
                tmp := tmp + 'supplyCostTotal (공급가액 합계) : ' + IntToStr(summaryInfo.supplyCostTotal) + #13;
                tmp := tmp + 'taxTotal (세액 합계) : ' + IntToStr(summaryInfo.taxTotal) + #13;
                tmp := tmp + 'amountTotal (합계 금액) : ' + IntToStr(summaryInfo.amountTotal) + #13;
                ShowMessage(tmp);
                exit;
        end;
end;

procedure TTfrmExample.btnGetTaxinvoiceClick(Sender: TObject);
var
        taxinvoice : THomeTaxTaxinvoice;
        tmp : string;
        ntsConfirmNum : string;
        i : Integer;
begin
        {**********************************************************************}
        { 국세청 승인번호를 통해 수집한 전자세금계산서 1건의 상세정보를 반환합니다.               
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/search#GetTaxinvoice
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

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin

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
                tmp := tmp + 'invoicerMgtKey (공급자 문서번호) : ' + taxinvoice.invoicerMgtKey +#13;
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
end;

procedure TTfrmExample.btnGetXMLClick(Sender: TObject);
var
        response : TGetXMLResponse;
        tmp : string;
        ntsConfirmNum : string;
begin
        {**********************************************************************}
        { 국세청 승인번호를 통해 수집한 전자세금계산서 1건의 상세정보를 XML 형태의 문자열로 반환합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/search#GetXML
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

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);                
        end
        else
        begin
                tmp := 'ResultCode (요청에 대한 응답 상태코드) : ' + IntToStr(response.ResultCode) + #13;
                tmp := tmp + 'Message (국세청승인번호) : ' + response.Message + #13;
                tmp := tmp + 'retObject (XML문서) : ' + #13 + response.retObject;
                ShowMessage(tmp);
        end;
end;

procedure TTfrmExample.btnGetCertificatePopUpURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        { 홈택스연동 인증정보를 관리하는 페이지의 팝업 URL을 반환합니다.
        { - 반환되는 URL은 보안 정책상 30초 동안 유효하며, 시간을 초과한 후에는 해당 URL을 통한 페이지 접근이 불가합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/cert#GetCertificatePopUpURL
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.GetCertificatePopUpURL(txtCorpNum.Text, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('ResultURL is ' + resultURL);
        end;
end;

procedure TTfrmExample.btnGetFlatRatePopUpURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        { 홈택스연동 정액제 서비스 신청 페이지의 팝업 URL을 반환합니다.
        { - 반환되는 URL은 보안 정책상 30초 동안 유효하며, 시간을 초과한 후에는 해당 URL을 통한 페이지 접근이 불가합니다.       ㄴ
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/point#GetFlatRatePopUpURL
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.GetFlatRatePopUpURL(txtCorpNum.Text, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('ResultURL is ' + resultURL);
        end;

end;

procedure TTfrmExample.btnGetCertificateExpireDateClick(Sender: TObject);
var
        expires : String;
begin
        {**********************************************************************}
        { 팝빌에 등록된 인증서 만료일자를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/cert#GetCertificateExpireDate
        {**********************************************************************}

        try
                expires := htTaxinvoiceService.GetCertificateExpireDate(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('ExpireDate is : ' + expires);
        end;

end;

procedure TTfrmExample.btnGetFlatRateStateClick(Sender: TObject);
var
        stateInfo : THometaxTIFlatRate;
        tmp : String;
begin
        {**********************************************************************}
        { 홈택스연동 정액제 서비스 상태를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/point#GetFlatRateState
        {**********************************************************************}

        try
                stateInfo := htTaxinvoiceService.GetFlatRateState(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin

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
end;

procedure TTfrmExample.btnGetChargeInfoClick(Sender: TObject);
var
        chargeInfo : THometaxTIChargeInfo;
        tmp : String;
begin
        {**********************************************************************}
        { 팝빌 홈택스연동(세금) API 서비스 과금정보를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/point#GetChargeInfo
        {**********************************************************************}

        try
                chargeInfo := htTaxinvoiceService.GetChargeInfo(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;

        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                tmp := 'unitCost (단가) : ' + chargeInfo.unitCost + #13;
                tmp := tmp + 'chargeMethod (과금유형) : ' + chargeInfo.chargeMethod + #13;
                tmp := tmp + 'rateSystem (과금제도) : ' + chargeInfo.rateSystem + #13;
                ShowMessage(tmp);
        end;
end;

procedure TTfrmExample.btnGetAccessURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        { 팝빌 사이트에 로그인 상태로 접근할 수 있는 페이지의 팝업 URL을 반환합니다.
        { - 반환되는 URL은 보안 정책상 30초 동안 유효하며, 시간을 초과한 후에는 해당 URL을 통한 페이지 접근이 불가합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/member#GetAccessURL
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.getAccessURL(txtCorpNum.Text, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
         if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL :' + #13 + resultURL);
        end;
end;

procedure TTfrmExample.btnGetChargeURLClick(Sender: TObject);
var
  resultURL : String;
begin
        {**********************************************************************}
        { 연동회원 포인트 충전을 위한 페이지의 팝업 URL을 반환합니다.                            
        { - 반환되는 URL은 보안 정책상 30초 동안 유효하며, 시간을 초과한 후에는 해당 URL을 통한 페이지 접근이 불가합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/point#GetChargeURL
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.getChargeURL(txtCorpNum.Text, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
         if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL :' + #13 + resultURL);
        end;
end;

procedure TTfrmExample.btnGetPartnerURL_CHRGClick(Sender: TObject);
var
  resultURL : String;
begin
        {**********************************************************************}
        { 파트너 포인트 충전을 위한 페이지의 팝업 URL을 반환합니다.
        { - 반환되는 URL은 보안 정책상 30초 동안 유효하며, 시간을 초과한 후에는 해당 URL을 통한 페이지 접근이 불가합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/point#GetPartnerURL      
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.getPartnerURL(txtCorpNum.Text, 'CHRG');
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
         if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL :' + #13 + resultURL);
        end;
end;

procedure TTfrmExample.btnGetPopUpURLClick(Sender: TObject);
var
  resultURL, NTSConfirmNum : String;
begin
        {**********************************************************************}
        { 수집된 전자세금계산서 1건의 상세내역을 확인하는 페이지의 팝업 URL을 반환합니다.
        { - 반환되는 URL은 보안 정책상 30초 동안 유효하며, 시간을 초과한 후에는 해당 URL을 통한 페이지 접근이 불가합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/search#GetPopUpURL
        {**********************************************************************}

        NTSConfirmNum := txtntsconfirmNum.text;
        txtURL.Text := resultURL;

        try
                resultURL := htTaxinvoiceService.getPopUpURL(txtCorpNum.Text, NTSConfirmNum, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL :' + #13 + resultURL);
        end;

end;

procedure TTfrmExample.btnCheckCertValidationClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 팝빌에 등록된 인증서로 홈택스 로그인 가능 여부를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/cert#CheckCertValidation
        {**********************************************************************}

        try
                response := htTaxinvoiceService.CheckCertValidation(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;
end;

procedure TTfrmExample.btnRegistDeptUserClick(Sender: TObject);
var
        response : TResponse;
        deptUserID, deptUserPWD : String;
begin
        {**********************************************************************}
        { 홈택스연동 인증을 위해 팝빌에 전자세금계산서용 부서사용자 계정을 등록합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/cert#RegistDeptUser
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
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;
end;

procedure TTfrmExample.btnCheckDeptUserClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 홈택스연동 인증을 위해 팝빌에 등록된 전자세금계산서용 부서사용자 계정을 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/cert#CheckDeptUser
        {**********************************************************************}

        try
                response := htTaxinvoiceService.CheckDeptUser(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;
end;

procedure TTfrmExample.btnCheckLoginDeptUserClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 팝빌에 등록된 전자세금계산서용 부서사용자 계정 정보로 홈택스 로그인 가능 여부를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/cert#CheckLoginDeptUser
        {**********************************************************************}

        try
                response := htTaxinvoiceService.CheckLoginDeptUser(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;
end;

procedure TTfrmExample.btnDeleteDeptUserClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { 팝빌에 등록된 홈택스 전자세금계산서용 부서사용자 계정을 삭제합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/cert#DeleteDeptUser
        {**********************************************************************}

        try
                response := htTaxinvoiceService.DeleteDeptUser(txtCorpNum.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('응답코드 : '+ IntToStr(response.code) + #10#13 +'응답메시지 : '+  response.Message);
        end;
end;

procedure TTfrmExample.btnGetPrintURLClick(Sender: TObject);
var
  resultURL, NTSConfirmNum : String;
begin
        {**********************************************************************}
        { 수집된 전자세금계산서 1건의 상세내역을 인쇄하는 페이지의 URL을 반환합니다.
        { - 반환되는 URL은 보안 정책상 30초 동안 유효하며, 시간을 초과한 후에는 해당 URL을 통한 페이지 접근이 불가합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/search#GetPrintURL
        {**********************************************************************}

        NTSConfirmNum := txtntsconfirmNum.text;

        try
                resultURL := htTaxinvoiceService.getPrintURL(txtCorpNum.Text, NTSConfirmNum, txtUserID.Text);
                txtURL.Text := resultURL;

        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : '+ IntToStr(le.code) + #10#13 +'응답메시지 : '+  le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL :  ' + #13 + resultURL);
        end;
end;

procedure TTfrmExample.btnGetPaymentURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        { 연동회원 포인트 결제내역 확인을 위한 페이지의 팝업 URL을 반환합니다.
        { - 반환되는 URL은 보안 정책상 30초 동안 유효하며, 시간을 초과한 후에는 해당 URL을 통한 페이지 접근이 불가합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/point#GetPaymentURL
        {**********************************************************************}
        
        try
                resultURL := htTaxinvoiceService.getPaymentURL(txtCorpNum.Text, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : ' + IntToStr(le.code) + #10#13 +'응답메시지 : '+ le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL :  ' + #13 + resultURL);
        end;
end;

procedure TTfrmExample.btnGetUseHistoryURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        { 연동회원 포인트 사용내역 확인을 위한 페이지의 팝업 URL을 반환합니다.
        { - 반환되는 URL은 보안 정책상 30초 동안 유효하며, 시간을 초과한 후에는 해당 URL을 통한 페이지 접근이 불가합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/point#GetUseHistoryURL
        {**********************************************************************}

        try
                resultURL := htTaxinvoiceService.getUseHistoryURL(txtCorpNum.Text, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : ' + IntToStr(le.code) + #10#13 +'응답메시지 : '+ le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : '+ IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+  htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL :  ' + #13 + resultURL);
        end;
end;

procedure TTfrmExample.btnGetContactInfoClick(Sender: TObject);
var
        contactInfo : TContactInfo;
        contactID : string;
        tmp : string;
begin
        {**********************************************************************}
        { 연동회원 사업자번호에 등록된 담당자(팝빌 로그인 계정) 정보를 확인합니다.
        { - https://developers.popbill.com/reference/httaxinvoice/delphi/api/member#GetContactInfo
        {**********************************************************************}

        contactID := 'testkorea';
        
        try
                contactInfo := htTaxinvoiceService.getContactInfo(txtCorpNum.Text, contactID);
        except
                on le : EPopbillException do begin
                        ShowMessage('응답코드 : ' + IntToStr(le.code) + #10#13 +'응답메시지 : '+ le.Message);
                        Exit;
                end;
        end;
        if htTaxinvoiceService.LastErrCode <> 0 then
        begin
                ShowMessage('응답코드 : ' + IntToStr(htTaxinvoiceService.LastErrCode) + #10#13 +'응답메시지 : '+ htTaxinvoiceService.LastErrMessage);
        end
        else
        begin
                tmp := 'id (아이디) : ' + contactInfo.id + #13;
                tmp := tmp + 'personName (담당자 성명) : ' + contactInfo.personName + #13;
                tmp := tmp + 'tel (담당자 연락처(전화번호)) : ' + contactInfo.tel + #13;
                tmp := tmp + 'email (담당자 이메일) : ' + contactInfo.email + #13;
                tmp := tmp + 'regDT (등록 일시) : ' + contactInfo.regDT + #13;
                tmp := tmp + 'searchRole (담당자 권한) : ' + contactInfo.searchRole + #13;
                tmp := tmp + 'mgrYN (관리자 여부) : ' + booltostr(contactInfo.mgrYN) + #13;
                tmp := tmp + 'state (계정상태) : ' + inttostr(contactInfo.state) + #13;
                ShowMessage(tmp);
        end
end;

end.
