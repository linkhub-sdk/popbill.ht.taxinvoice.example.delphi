object TfrmExample: TTfrmExample
  Left = 382
  Top = 139
  Width = 1106
  Height = 792
  Caption = '�˺� Ȩ�ý� ����(����)��꼭 ���� API SDK Example'
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
    Caption = '�˺�ȸ�� ����ڹ�ȣ : '
  end
  object Label4: TLabel
    Left = 304
    Top = 12
    Width = 81
    Height = 13
    AutoSize = False
    Caption = '�˺����̵� : '
  end
  object GroupBox8: TGroupBox
    Left = 8
    Top = 40
    Width = 1081
    Height = 161
    Caption = '�˺� �⺻ API'
    TabOrder = 0
    object GroupBox9: TGroupBox
      Left = 8
      Top = 24
      Width = 137
      Height = 121
      Caption = 'ȸ������'
      TabOrder = 0
      object btnJoinMember: TButton
        Left = 8
        Top = 88
        Width = 120
        Height = 25
        Caption = 'ȸ�� ����'
        TabOrder = 0
        OnClick = btnJoinMemberClick
      end
      object btnCheckIsMember: TButton
        Left = 8
        Top = 24
        Width = 120
        Height = 25
        Caption = '���Կ���Ȯ��'
        TabOrder = 1
        OnClick = btnCheckIsMemberClick
      end
      object btnCheckID: TButton
        Left = 8
        Top = 56
        Width = 121
        Height = 25
        Caption = 'ID �ߺ� Ȯ��'
        TabOrder = 2
        OnClick = btnCheckIDClick
      end
    end
    object GroupBox11: TGroupBox
      Left = 152
      Top = 24
      Width = 145
      Height = 121
      Caption = '����Ʈ ����'
      TabOrder = 1
      object btnGetChargeInfo: TButton
        Left = 8
        Top = 24
        Width = 129
        Height = 25
        Caption = '�������� Ȯ��'
        TabOrder = 0
        OnClick = btnGetChargeInfoClick
      end
    end
    object GroupBox4: TGroupBox
      Left = 608
      Top = 24
      Width = 145
      Height = 121
      Caption = '����� ����'
      TabOrder = 2
      object btnUpdateContact: TButton
        Left = 8
        Top = 88
        Width = 129
        Height = 25
        Caption = '����� ���� ����'
        TabOrder = 0
        OnClick = btnUpdateContactClick
      end
      object btnRegistContact: TButton
        Left = 8
        Top = 24
        Width = 129
        Height = 25
        Caption = '����� �߰�'
        TabOrder = 1
        OnClick = btnRegistContactClick
      end
      object btnListContact: TButton
        Left = 8
        Top = 56
        Width = 129
        Height = 25
        Caption = '����� ��� ��ȸ'
        TabOrder = 2
        OnClick = btnListContactClick
      end
    end
    object GroupBox16: TGroupBox
      Left = 760
      Top = 24
      Width = 145
      Height = 121
      Caption = 'ȸ������ ����'
      TabOrder = 3
      object btnGetCorpInfo: TButton
        Left = 8
        Top = 24
        Width = 128
        Height = 25
        Caption = 'ȸ������ ��ȸ'
        TabOrder = 0
        OnClick = btnGetCorpInfoClick
      end
      object btnUpdateCorpInfo: TButton
        Left = 8
        Top = 56
        Width = 128
        Height = 25
        Caption = 'ȸ������ ����'
        TabOrder = 1
        OnClick = btnUpdateCorpInfoClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 912
      Top = 24
      Width = 153
      Height = 121
      Caption = '��Ÿ'
      TabOrder = 4
      object btnGetAccessURL: TButton
        Left = 8
        Top = 24
        Width = 129
        Height = 25
        Caption = '�˺� �α��� URL'
        TabOrder = 0
        OnClick = btnGetAccessURLClick
      end
    end
    object GroupBox7: TGroupBox
      Left = 304
      Top = 24
      Width = 146
      Height = 121
      Caption = '�������� ����Ʈ'
      TabOrder = 5
      object btnGetChargeURL: TButton
        Left = 8
        Top = 56
        Width = 129
        Height = 25
        Caption = '����Ʈ���� URL'
        TabOrder = 0
        OnClick = btnGetChargeURLClick
      end
      object btnGetBalance: TButton
        Left = 8
        Top = 24
        Width = 129
        Height = 25
        Caption = '�ܿ�����Ʈ Ȯ��'
        TabOrder = 1
        OnClick = btnGetBalanceClick
      end
    end
    object GroupBox10: TGroupBox
      Left = 456
      Top = 24
      Width = 147
      Height = 121
      Caption = '��Ʈ�ʰ��� ����Ʈ'
      TabOrder = 6
      object btnGetPartnerBalance: TButton
        Left = 8
        Top = 24
        Width = 129
        Height = 25
        Caption = '��Ʈ������Ʈ Ȯ��'
        TabOrder = 0
        OnClick = btnGetPartnerBalanceClick
      end
      object btnGetPartnerURL_CHRG: TButton
        Left = 8
        Top = 56
        Width = 129
        Height = 25
        Caption = '����Ʈ���� URL'
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
    Caption = 'Ȩ�ý� ���ڼ��ݰ�꼭 ���� ���� API '
    TabOrder = 3
    object Label2: TLabel
      Left = 304
      Top = 216
      Width = 265
      Height = 13
      AutoSize = False
      Caption = '(�۾����̵�� '#39'���� ��û'#39' ȣ��� �����˴ϴ�.)'
    end
    object Label1: TLabel
      Left = 24
      Top = 216
      Width = 114
      Height = 17
      AutoSize = False
      Caption = '�۾����̵� (jobID) :'
    end
    object GroupBox6: TGroupBox
      Left = 352
      Top = 24
      Width = 303
      Height = 169
      Caption = '����(����)��꼭 ������ ��ȸ'
      TabOrder = 15
      object Label7: TLabel
        Left = 8
        Top = 24
        Width = 101
        Height = 13
        AutoSize = False
        Caption = '����û���ι�ȣ : '
      end
      object Label8: TLabel
        Left = 8
        Top = 48
        Width = 279
        Height = 13
        AutoSize = False
        Caption = '('#39'������� ��ȸ'#39' �� �׸����� ���� �����Ͻʽÿ�.)'
      end
      object btnGetPopUpURL: TButton
        Left = 112
        Top = 136
        Width = 172
        Height = 25
        Caption = '���ݰ�꼭 ���� �˾�'
        TabOrder = 0
        OnClick = btnGetPopUpURLClick
      end
    end
    object GroupBox5: TGroupBox
      Left = 168
      Top = 24
      Width = 177
      Height = 169
      Caption = '����/���� ������� ��ȸ'
      TabOrder = 14
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 24
      Width = 145
      Height = 169
      Caption = '����/���� ���� ����'
      TabOrder = 13
    end
    object btnGetTaxinvoice: TButton
      Left = 464
      Top = 96
      Width = 172
      Height = 25
      Caption = '������ ��ȸ'
      TabOrder = 6
      OnClick = btnGetTaxinvoiceClick
    end
    object btnGetXML: TButton
      Left = 464
      Top = 128
      Width = 172
      Height = 25
      Caption = '������ ��ȸ - XML'
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
      Caption = '�ΰ����'
      TabOrder = 12
    end
    object btnGetFlatRatePopUpURL: TButton
      Left = 672
      Top = 48
      Width = 161
      Height = 25
      Caption = '������ ���� ��û URL'
      TabOrder = 8
      OnClick = btnGetFlatRatePopUpURLClick
    end
    object btnGetFlatRateState: TButton
      Left = 672
      Top = 80
      Width = 161
      Height = 25
      Caption = '������ ���� ���� Ȯ��'
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
      Caption = '���� ��û'
      TabOrder = 0
      OnClick = btnRequestJobClick
    end
    object btnSearch: TButton
      Left = 176
      Top = 48
      Width = 159
      Height = 25
      Caption = '���� ��� ��ȸ'
      TabOrder = 4
      OnClick = btnSearchClick
    end
    object btnSummary: TButton
      Left = 176
      Top = 80
      Width = 159
      Height = 25
      Caption = '���� ��� ������� ��ȸ'
      TabOrder = 5
      OnClick = btnSummaryClick
    end
    object btnGetJobState: TButton
      Left = 24
      Top = 80
      Width = 129
      Height = 25
      Caption = '���� ���� Ȯ��'
      TabOrder = 2
      OnClick = btnGetJobStateClick
    end
    object btnListActiveJob: TButton
      Left = 24
      Top = 112
      Width = 129
      Height = 25
      Caption = '���� ���� ��� Ȯ��'
      TabOrder = 3
      OnClick = btnListActiveJobClick
    end
    object GroupBox12: TGroupBox
      Left = 856
      Top = 24
      Width = 209
      Height = 249
      Caption = 'Ȩ�ý� �������� ���'
      TabOrder = 16
      object btnGetCertificateExpireDate: TButton
        Left = 8
        Top = 56
        Width = 185
        Height = 25
        Caption = '���������� �������� Ȯ��'
        TabOrder = 0
        OnClick = btnGetCertificateExpireDateClick
      end
      object btnGetCertificatePopUpURL: TButton
        Left = 8
        Top = 24
        Width = 185
        Height = 25
        Caption = 'Ȩ�ý����� �������� URL'
        TabOrder = 1
        OnClick = btnGetCertificatePopUpURLClick
      end
      object btnCheckCertValidation: TButton
        Left = 8
        Top = 88
        Width = 185
        Height = 25
        Caption = '���������� �α��� �׽�Ʈ'
        TabOrder = 2
        OnClick = btnCheckCertValidationClick
      end
      object btnRegistDeptUser: TButton
        Left = 8
        Top = 120
        Width = 185
        Height = 25
        Caption = '�μ������ �������'
        TabOrder = 3
        OnClick = btnRegistDeptUserClick
      end
      object btnCheckDeptUser: TButton
        Left = 8
        Top = 152
        Width = 185
        Height = 25
        Caption = '�μ������ ������� Ȯ��'
        TabOrder = 4
        OnClick = btnCheckDeptUserClick
      end
      object btnCheckLoginDeptUser: TButton
        Left = 8
        Top = 184
        Width = 185
        Height = 25
        Caption = '�μ������ �α��� �׽�Ʈ'
        TabOrder = 5
        OnClick = btnCheckLoginDeptUserClick
      end
      object btnDeleteDeptUser: TButton
        Left = 8
        Top = 216
        Width = 185
        Height = 25
        Caption = '�μ������ ������� ����'
        TabOrder = 6
        OnClick = btnDeleteDeptUserClick
      end
    end
  end
end
