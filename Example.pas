unit Example;

interface

uses
Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, TypInfo,
  Popbill, PopbillHTTaxinvoice, ExtCtrls, Grids;
  
const
        //링크아이디.
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
    btnGetBalance: TButton;
    btnGetPartnerBalance: TButton;
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
    btnGetPopbillURL_CHRG: TButton;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
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

        //연동환경 설정값, true(테스트용), false(상업용)
        htTaxinvoiceService.IsTest := true;
        
        //Exception 처리 설정값. 미기재시 true(기본값) 
        htTaxinvoiceService.IsThrowException := true;

        StringGrid1.Cells[0,0] := '작성일자';
        StringGrid1.Cells[1,0] := '발행일자';
        StringGrid1.Cells[2,0] := '전송일자';
        StringGrid1.Cells[3,0] := '거래처';
        StringGrid1.Cells[4,0] := '거래처 사업자번호';
        StringGrid1.Cells[5,0] := '과세형태';
        StringGrid1.Cells[6,0] := '공급가액';
        StringGrid1.Cells[7,0] := '문서형태';
        StringGrid1.Cells[8,0] := '국세청승인번호';


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
        joinInfo.LinkID := LinkID;        //링크아이디
        joinInfo.CorpNum := '1231212312'; //사업자번호 '-' 제외.
        joinInfo.CEOName := '대표자성명';
        joinInfo.CorpName := '상호';
        joinInfo.Addr := '주소';
        joinInfo.BizType := '업태';
        joinInfo.BizClass := '업종';
        joinInfo.ID     := 'userid';  //6자 이상 20자 미만.
        joinInfo.PWD    := 'pwd_must_be_long_enough'; //6자 이상 20자 미만.
        joinInfo.ContactName := '담당자명';
        joinInfo.ContactTEL :='02-999-9999';
        joinInfo.ContactHP := '010-1234-5678';
        joinInfo.ContactFAX := '02-999-9998';
        joinInfo.ContactEmail := 'test@test.com';

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
        try
                balance := htTaxinvoiceService.GetBalance(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('잔여포인트 : ' + FloatToStr(balance));

end;

procedure TTfrmExample.btnGetPartnerBalanceClick(Sender: TObject);
var
        balance : Double;
begin
         try
                balance := htTaxinvoiceService.GetPartnerBalance(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
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
        joinInfo.id := 'userid';                        // [필수] 아이디 (6자 이상 20자 미만)
        joinInfo.pwd := 'thisispassword';               // [필수] 비밀번호 (6자 이상 20자 미만)
        joinInfo.personName := '담당자성명';            // [필수] 담당자명(한글이나 영문 30자 이내)
        joinInfo.tel := '070-7510-3710';                // [필수] 연락처
        joinInfo.hp := '010-1111-2222';                 // 휴대폰번호
        joinInfo.fax := '02-6442-9700';                 // 팩스번호
        joinInfo.email := 'test@test.com';              // [필수] 이메일
        joinInfo.searchAllAllowYN := false;             // 조회권한(true 회사조회/ false 개인조회)
        joinInfo.mgrYN     := false;                    // 관리자 권한여부 

        try
                response := htTaxinvoiceService.RegistContact(txtCorpNum.text,joinInfo,txtUserID.text);
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

        try
                InfoList := htTaxinvoiceService.ListContact(txtCorpNum.text,txtUserID.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;
        tmp := 'id | email | hp | personName | searchAllAlloyYN | tel | fax | mgrYN | regDT' + #13;
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
            tmp := tmp + InfoList[i].regDT + #13;
        end;

        ShowMessage(tmp);
end;

procedure TTfrmExample.btnUpdateContactClick(Sender: TObject);
var
        contactInfo : TContactInfo;
        response : TResponse;
begin
        contactInfo := TContactInfo.Create;

        contactInfo.personName := '테스트 담당자';      // 담당자명
        contactInfo.tel := '070-7510-3710';             // 연락처
        contactInfo.hp := '010-4324-1111';              // 휴대폰번호
        contactInfo.email := 'test@test.com';           // 이메일 주소
        contactInfo.fax := '02-6442-9799';              // 팩스번호
        contactInfo.searchAllAllowYN := true;           // 조회권한, true(회사조회), false(개인조회)
        contactInfo.mgrYN := false;                     // 관리자권한 설정여부 

        try
                response := htTaxinvoiceService.UpdateContact(txtCorpNum.text,contactInfo,txtUserID.Text);
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
        try
                corpInfo := htTaxinvoiceService.GetCorpInfo(txtCorpNum.text, txtUserID.Text);
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
        corpInfo := TCorpInfo.Create;

        corpInfo.ceoname := '대표자명';         // 대표자명
        corpInfo.corpName := '팝빌';    // 회사명
        corpInfo.bizType := '업태';             // 업태
        corpInfo.bizClass := '업종';            // 업종
        corpInfo.addr := '서울특별시 강남구 영동대로 517';  // 주소
        
        try
                response := htTaxinvoiceService.UpdateCorpInfo(txtCorpNum.text,corpInfo,txtUserID.Text);
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
        // 수집 요청시 반환되는 작업아이디(jobID)의 유효시간은 1시간입니다.

        
        // 전자세금계산서 유형 SELL- 매출, BUY- 매입, TRUSTEE-위수탁
        queryType := SELL;

        // 수집 일자 유형 W-작성일자, I-발행일자, S-전송일자
        DType := 'W';

        // 시작일자, 날자형식(yyyyMMdd)
        SDate := '20160501';

        // 종료일자, 날자형식(yyyyMMdd)
        EDate := '20160701';
        
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
        try
                // 수집상태확인 GetJobState(팝빌회원 사업자번호, 작업아이디)
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

        try
                // 1시간 이내 수집 요청한 작업아이디 목록을 확인합니다.
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

        // 종사업업자번호 사업자 유형 공백-전체조회, S-공급자, B-공급받는자, T-수탁자
        TaxRegIDType := '';

        // 종사업장번호 콤마(,)로 구분하여 구성.  ex) '1234,0001'
        TaxRegID := '';

        //종사업장번호 유무
        TaxRegIDYN := '';      // 공백 - 전체조회, 0-종사업장번호 없는것만 조회, 1-종사업장번호 조건에 따라 검색

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
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'code (응답코드) : ' + IntToStr(searchInfo.code) + #13;
        tmp := tmp + 'total (총 검색결과 건수) : ' + IntToStr(searchInfo.total) + #13;
        tmp := tmp + 'perPage (페이지당 검색개수) : ' + IntToStr(searchInfo.perPage) + #13;
        tmp := tmp + 'pageNum (페이지 번호) : ' + IntToStr(searchInfo.pageNum) + #13;
        tmp := tmp + 'pageCount (페이지 개수) : ' + IntToStr(searchInfo.pageCount)+ #13;
        tmp := tmp + 'message (응답 메시지) : ' + searchInfo.message + #13 + #13;


        for i:=0 to length(searchInfo.list)-1 do
        begin

                StringGrid1.Cells[0, i+1] := searchInfo.list[i].writeDate;
                StringGrid1.Cells[1, i+1] := searchInfo.list[i].issueDate;
                StringGrid1.Cells[2, i+1] := searchInfo.list[i].sendDate;
                StringGrid1.Cells[3, i+1] := searchInfo.list[i].invoiceeCorpName;
                StringGrid1.Cells[4, i+1] := searchInfo.list[i].invoiceeCorpNum;
                StringGrid1.Cells[5, i+1] := searchInfo.list[i].taxType;
                StringGrid1.Cells[6, i+1] := searchInfo.list[i].supplyCostTotal;
                //  API호출시 반환되는 추가적인 전자(세금)계산서 항목은
                //  [링크허브]팝빌 -홈택스 전자세금계산서 API 연동매뉴얼 '4.1.1. Search' 를 참조하시기 바랍니다.


                if searchInfo.list[i].modifyYN then
                begin
                        StringGrid1.Cells[7, i+1] :='수정';
                end
                else
                        StringGrid1.Cells[7, i+1] :='일반';
                
                StringGrid1.Cells[8, i+1] := searchInfo.list[i].ntsconfirmNum;

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

        // 종사업업자번호 사업자 유형 S-공급자, B-공급받는자, T-수탁자
        TaxRegIDType := 'S';

        // 종사업장번호, 콤마(,)로 구분하여 구성 ex)0001,0007
        taxRegID := '';

        //종사업장번호 유무
        TaxRegIDYN := '';      // 공백 - 전체조회, 0-종사업장번호 없는것만 조회, 1-유형, 목록으로 검색

        try
                summaryInfo := htTaxinvoiceService.Summary(txtCorpNum.text, txtJobId.text,DocType,TaxType, PurposeType, TaxRegIDType, TaxRegID, TaxRegIDYN);

        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
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
        ntsConfirmNum := txtntsconfirmNum.Text;
        
        try
                taxinvoice := htTaxinvoiceService.getTaxinvoice(txtCorpNum.text,ntsConfirmNum);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
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
        ntsConfirmNum := txtntsconfirmNum.Text;
        
        try
                response := htTaxinvoiceService.getXML(txtCorpNum.text,ntsConfirmNum);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'ResultCode (응답코드) : ' + IntToStr(response.ResultCode) + #13;
        tmp := tmp + 'Message (국세청승인번호) : ' + response.Message + #13;
        tmp := tmp + 'retObject (XML문서) : ' + #13 + response.retObject;

        ShowMessage(tmp);

end;

procedure TTfrmExample.btnGetCertificatePopUpURLClick(Sender: TObject);
var
        resultURL : String;
begin
        try
                resultURL := htTaxinvoiceService.GetCertificatePopUpURL(txtCorpNum.Text,txtUserID.Text);
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
        try
                resultURL := htTaxinvoiceService.GetFlatRatePopUpURL(txtCorpNum.Text,txtUserID.Text);
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

        try
                stateInfo := htTaxinvoiceService.GetFlatRateState(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
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

        try
                chargeInfo := htTaxinvoiceService.GetChargeInfo(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        tmp := 'unitCost (단가) : ' + chargeInfo.unitCost + #13;
        tmp := tmp + 'chargeMethod (과금유형) : ' + chargeInfo.chargeMethod + #13;
        tmp := tmp + 'rateSystem (과금제도) : ' + chargeInfo.rateSystem + #13;

        ShowMessage(tmp);
end;

procedure TTfrmExample.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
        if StringGrid1.Cells[8, Arow] <> '' then
        begin
                txtntsconfirmNum.Text := StringGrid1.Cells[8, Arow];
        end
        
end;

procedure TTfrmExample.btnGetPopbillURL_LOGINClick(Sender: TObject);
var
  resultURL : String;
begin

        try
                resultURL := htTaxinvoiceService.getPopbillURL(txtCorpNum.Text,txtUserID.Text,'LOGIN');
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('팝빌 로그인 URL' + #13 + resultURL);
end;

procedure TTfrmExample.btnGetPopbillURL_CHRGClick(Sender: TObject);
var
  resultURL : String;
begin

        try
                resultURL := htTaxinvoiceService.getPopbillURL(txtCorpNum.Text,txtUserID.Text,'CHRG');
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        ShowMessage('포인트충전 URL ' + #13 + resultURL);
end;

end.
