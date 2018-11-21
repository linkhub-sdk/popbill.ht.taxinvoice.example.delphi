object TfrmExample: TTfrmExample
  Left = 382
  Top = 139
  Width = 1106
  Height = 792
  Caption = '팝빌 홈택스 전자(세금)계산서 연계 API SDK Example'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 16
    Top = 12
    Width = 129
    Height = 13
    AutoSize = False
    Caption = '팝빌회원 사업자번호 : '
  end
  object Label4: TLabel
    Left = 304
    Top = 12
    Width = 81
    Height = 13
    AutoSize = False
    Caption = '팝빌아이디 : '
  end
  object GroupBox8: TGroupBox
    Left = 8
    Top = 40
    Width = 1081
    Height = 161
    Caption = '팝빌 기본 API'
    TabOrder = 0
    object GroupBox9: TGroupBox
      Left = 8
      Top = 24
      Width = 137
      Height = 121
      Caption = '회원가입'
      TabOrder = 0
      object btnJoinMember: TButton
        Left = 8
        Top = 88
        Width = 120
        Height = 25
        Caption = '회원 가입'
        TabOrder = 0
        OnClick = btnJoinMemberClick
      end
      object btnCheckIsMember: TButton
        Left = 8
        Top = 24
        Width = 120
        Height = 25
        Caption = '가입여부확인'
        TabOrder = 1
        OnClick = btnCheckIsMemberClick
      end
      object btnCheckID: TButton
        Left = 8
        Top = 56
        Width = 121
        Height = 25
        Caption = 'ID 중복 확인'
        TabOrder = 2
        OnClick = btnCheckIDClick
      end
    end
    object GroupBox11: TGroupBox
      Left = 152
      Top = 24
      Width = 145
      Height = 121
      Caption = '포인트 관련'
      TabOrder = 1
      object btnGetChargeInfo: TButton
        Left = 8
        Top = 24
        Width = 129
        Height = 25
        Caption = '과금정보 확인'
        TabOrder = 0
        OnClick = btnGetChargeInfoClick
      end
    end
    object GroupBox4: TGroupBox
      Left = 608
      Top = 24
      Width = 145
      Height = 121
      Caption = '담당자 관련'
      TabOrder = 2
      object btnUpdateContact: TButton
        Left = 8
        Top = 88
        Width = 129
        Height = 25
        Caption = '담당자 정보 수정'
        TabOrder = 0
        OnClick = btnUpdateContactClick
      end
      object btnRegistContact: TButton
        Left = 8
        Top = 24
        Width = 129
        Height = 25
        Caption = '담당자 추가'
        TabOrder = 1
        OnClick = btnRegistContactClick
      end
      object btnListContact: TButton
        Left = 8
        Top = 56
        Width = 129
        Height = 25
        Caption = '담당자 목록 조회'
        TabOrder = 2
        OnClick = btnListContactClick
      end
    end
    object GroupBox16: TGroupBox
      Left = 760
      Top = 24
      Width = 145
      Height = 121
      Caption = '회사정보 관련'
      TabOrder = 3
      object btnGetCorpInfo: TButton
        Left = 8
        Top = 24
        Width = 128
        Height = 25
        Caption = '회사정보 조회'
        TabOrder = 0
        OnClick = btnGetCorpInfoClick
      end
      object btnUpdateCorpInfo: TButton
        Left = 8
        Top = 56
        Width = 128
        Height = 25
        Caption = '회사정보 수정'
        TabOrder = 1
        OnClick = btnUpdateCorpInfoClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 912
      Top = 24
      Width = 153
      Height = 121
      Caption = '기타'
      TabOrder = 4
      object btnGetAccessURL: TButton
        Left = 8
        Top = 24
        Width = 129
        Height = 25
        Caption = '팝빌 로그인 URL'
        TabOrder = 0
        OnClick = btnGetAccessURLClick
      end
    end
    object GroupBox7: TGroupBox
      Left = 304
      Top = 24
      Width = 146
      Height = 121
      Caption = '연동과금 포인트'
      TabOrder = 5
      object btnGetChargeURL: TButton
        Left = 8
        Top = 56
        Width = 129
        Height = 25
        Caption = '포인트충전 URL'
        TabOrder = 0
        OnClick = btnGetChargeURLClick
      end
      object btnGetBalance: TButton
        Left = 8
        Top = 24
        Width = 129
        Height = 25
        Caption = '잔여포인트 확인'
        TabOrder = 1
        OnClick = btnGetBalanceClick
      end
    end
    object GroupBox10: TGroupBox
      Left = 456
      Top = 24
      Width = 147
      Height = 121
      Caption = '파트너과금 포인트'
      TabOrder = 6
      object btnGetPartnerBalance: TButton
        Left = 8
        Top = 24
        Width = 129
        Height = 25
        Caption = '파트너포인트 확인'
        TabOrder = 0
        OnClick = btnGetPartnerBalanceClick
      end
      object btnGetPartnerURL_CHRG: TButton
        Left = 8
        Top = 56
        Width = 129
        Height = 25
        Caption = '포인트충전 URL'
        TabOrder = 1
        OnClick = btnGetPartnerURL_CHRGClick
      end
    end
  end
  object txtCorpNum: TEdit
    Left = 144
    Top = 8
    Width = 137
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 1
    Text = '1234567890'
  end
  object txtUserID: TEdit
    Left = 384
    Top = 8
    Width = 137
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 2
    Text = 'testkorea'
  end
  object TGroupBox
    Left = 8
    Top = 216
    Width = 1081
    Height = 529
    Caption = '홈택스 전자세금계산서 연계 관련 API '
    TabOrder = 3
    object Label2: TLabel
      Left = 304
      Top = 216
      Width = 265
      Height = 13
      AutoSize = False
      Caption = '(작업아이디는 '#39'수집 요청'#39' 호출시 생성됩니다.)'
    end
    object Label1: TLabel
      Left = 24
      Top = 216
      Width = 114
      Height = 17
      AutoSize = False
      Caption = '작업아이디 (jobID) :'
    end
    object GroupBox6: TGroupBox
      Left = 352
      Top = 24
      Width = 303
      Height = 169
      Caption = '전자(세금)계산서 상세정보 조회'
      TabOrder = 15
      object Label7: TLabel
        Left = 8
        Top = 24
        Width = 101
        Height = 13
        AutoSize = False
        Caption = '국세청승인번호 : '
      end
      object Label8: TLabel
        Left = 8
        Top = 48
        Width = 279
        Height = 13
        AutoSize = False
        Caption = '('#39'수집결과 조회'#39' 후 그리드의 셀을 선택하십시오.)'
      end
      object btnGetPopUpURL: TButton
        Left = 112
        Top = 136
        Width = 172
        Height = 25
        Caption = '세금계산서 보기 팝업'
        TabOrder = 0
        OnClick = btnGetPopUpURLClick
      end
    end
    object GroupBox5: TGroupBox
      Left = 168
      Top = 24
      Width = 177
      Height = 169
      Caption = '매출/매입 수집결과 조회'
      TabOrder = 14
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 24
      Width = 145
      Height = 169
      Caption = '매출/매입 내역 수집'
      TabOrder = 13
    end
    object btnGetTaxinvoice: TButton
      Left = 464
      Top = 96
      Width = 172
      Height = 25
      Caption = '상세정보 조회'
      TabOrder = 6
      OnClick = btnGetTaxinvoiceClick
    end
    object btnGetXML: TButton
      Left = 464
      Top = 128
      Width = 172
      Height = 25
      Caption = '상세정보 조회 - XML'
      TabOrder = 7
      OnClick = btnGetXMLClick
    end
    object StringGrid1: TStringGrid
      Left = 24
      Top = 248
      Width = 817
      Height = 265
      BiDiMode = bdLeftToRight
      ColCount = 10
      DefaultRowHeight = 27
      FixedCols = 0
      RowCount = 11
      ParentBiDiMode = False
      TabOrder = 10
      OnSelectCell = StringGrid1SelectCell
      ColWidths = (
        62
        61
        64
        68
        138
        128
        76
        87
        72
        187)
    end
    object txtntsconfirmNum: TEdit
      Left = 464
      Top = 45
      Width = 172
      Height = 21
      ImeName = 'Microsoft IME 2010'
      TabOrder = 11
    end
    object GroupBox1: TGroupBox
      Left = 664
      Top = 24
      Width = 182
      Height = 169
      Caption = '부가기능'
      TabOrder = 12
    end
    object btnGetFlatRatePopUpURL: TButton
      Left = 672
      Top = 48
      Width = 161
      Height = 25
      Caption = '정액제 서비스 신청 URL'
      TabOrder = 8
      OnClick = btnGetFlatRatePopUpURLClick
    end
    object btnGetFlatRateState: TButton
      Left = 672
      Top = 80
      Width = 161
      Height = 25
      Caption = '정액제 서비스 상태 확인'
      TabOrder = 9
      OnClick = btnGetFlatRateStateClick
    end
    object txtJobID: TEdit
      Left = 136
      Top = 212
      Width = 153
      Height = 21
      ImeName = 'Microsoft IME 2010'
      TabOrder = 1
    end
    object btnRequestJob: TButton
      Left = 24
      Top = 48
      Width = 129
      Height = 25
      Caption = '수집 요청'
      TabOrder = 0
      OnClick = btnRequestJobClick
    end
    object btnSearch: TButton
      Left = 176
      Top = 48
      Width = 159
      Height = 25
      Caption = '수집 결과 조회'
      TabOrder = 4
      OnClick = btnSearchClick
    end
    object btnSummary: TButton
      Left = 176
      Top = 80
      Width = 159
      Height = 25
      Caption = '수집 결과 요약정보 조회'
      TabOrder = 5
      OnClick = btnSummaryClick
    end
    object btnGetJobState: TButton
      Left = 24
      Top = 80
      Width = 129
      Height = 25
      Caption = '수집 상태 확인'
      TabOrder = 2
      OnClick = btnGetJobStateClick
    end
    object btnListActiveJob: TButton
      Left = 24
      Top = 112
      Width = 129
      Height = 25
      Caption = '수집 상태 목록 확인'
      TabOrder = 3
      OnClick = btnListActiveJobClick
    end
    object GroupBox12: TGroupBox
      Left = 856
      Top = 24
      Width = 209
      Height = 249
      Caption = '홈택스 인증관련 기능'
      TabOrder = 16
      object btnGetCertificateExpireDate: TButton
        Left = 8
        Top = 56
        Width = 185
        Height = 25
        Caption = '공인인증서 만료일자 확인'
        TabOrder = 0
        OnClick = btnGetCertificateExpireDateClick
      end
      object btnGetCertificatePopUpURL: TButton
        Left = 8
        Top = 24
        Width = 185
        Height = 25
        Caption = '홈택스연동 인증관리 URL'
        TabOrder = 1
        OnClick = btnGetCertificatePopUpURLClick
      end
      object btnCheckCertValidation: TButton
        Left = 8
        Top = 88
        Width = 185
        Height = 25
        Caption = '공인인증서 로그인 테스트'
        TabOrder = 2
        OnClick = btnCheckCertValidationClick
      end
      object btnRegistDeptUser: TButton
        Left = 8
        Top = 120
        Width = 185
        Height = 25
        Caption = '부서사용자 계정등록'
        TabOrder = 3
        OnClick = btnRegistDeptUserClick
      end
      object btnCheckDeptUser: TButton
        Left = 8
        Top = 152
        Width = 185
        Height = 25
        Caption = '부서사용자 등록정보 확인'
        TabOrder = 4
        OnClick = btnCheckDeptUserClick
      end
      object btnCheckLoginDeptUser: TButton
        Left = 8
        Top = 184
        Width = 185
        Height = 25
        Caption = '부서사용자 로그인 테스트'
        TabOrder = 5
        OnClick = btnCheckLoginDeptUserClick
      end
      object btnDeleteDeptUser: TButton
        Left = 8
        Top = 216
        Width = 185
        Height = 25
        Caption = '부서사용자 등록정보 삭제'
        TabOrder = 6
        OnClick = btnDeleteDeptUserClick
      end
    end
  end
end
