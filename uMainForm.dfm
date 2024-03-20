object Form1: TForm1
  Left = 1077
  Top = 305
  Width = 704
  Height = 351
  Caption = 'QD Test Stuff'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    696
    317)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 88
    Top = 8
    Width = 601
    Height = 297
    TabOrder = 9
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 393
      Height = 121
      Caption = 'Address'
      TabOrder = 0
      object Label5: TLabel
        Left = 8
        Top = 24
        Width = 81
        Height = 13
        Caption = 'Address Number:'
      end
      object Label6: TLabel
        Left = 16
        Top = 56
        Width = 72
        Height = 13
        Caption = 'Address Name:'
      end
      object Label12: TLabel
        Left = 24
        Top = 88
        Width = 59
        Height = 13
        Caption = 'Address Zip:'
      end
      object edtAddrNum: TEdit
        Left = 96
        Top = 24
        Width = 73
        Height = 21
        TabOrder = 0
      end
      object edtAddrName: TEdit
        Left = 96
        Top = 56
        Width = 217
        Height = 21
        TabOrder = 1
      end
      object edtAptNum: TEdit
        Left = 320
        Top = 56
        Width = 65
        Height = 21
        TabOrder = 2
      end
      object edtAddrZip: TEdit
        Left = 96
        Top = 88
        Width = 121
        Height = 21
        TabOrder = 3
      end
    end
    object btnCreateAddress: TButton
      Left = 8
      Top = 136
      Width = 89
      Height = 25
      Caption = 'Create Address'
      TabOrder = 1
      OnClick = btnCreateAddressClick
    end
  end
  object Panel4: TPanel
    Left = 88
    Top = 8
    Width = 601
    Height = 297
    TabOrder = 8
    object Label4: TLabel
      Left = 24
      Top = 8
      Width = 59
      Height = 13
      Caption = 'State Name:'
    end
    object Label3: TLabel
      Left = 12
      Top = 40
      Width = 70
      Height = 13
      Caption = 'Country Name:'
    end
    object edtStateName: TEdit
      Left = 88
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtCountryName: TEdit
      Left = 88
      Top = 40
      Width = 321
      Height = 21
      TabOrder = 1
    end
    object btnCreateCountry: TButton
      Left = 16
      Top = 72
      Width = 121
      Height = 25
      Caption = 'Create State/Country'
      TabOrder = 2
      OnClick = btnCreateCountryClick
    end
  end
  object Panel3: TPanel
    Left = 88
    Top = 8
    Width = 601
    Height = 297
    TabOrder = 5
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 67
      Height = 13
      Caption = 'County Name:'
    end
    object edtCountyName: TEdit
      Left = 80
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object btnCreateCounty: TButton
      Left = 208
      Top = 8
      Width = 81
      Height = 25
      Caption = 'Create County'
      TabOrder = 1
      OnClick = btnCreateCountyClick
    end
  end
  object Panel2: TPanel
    Left = 88
    Top = 8
    Width = 601
    Height = 297
    Enabled = False
    TabOrder = 4
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 51
      Height = 13
      Caption = 'City Name:'
    end
    object edtCityName: TEdit
      Left = 64
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object rgCityTypes: TRadioGroup
      Left = 8
      Top = 32
      Width = 177
      Height = 153
      Caption = 'City Types'
      ItemIndex = 0
      Items.Strings = (
        'Lost'
        'Site'
        'Community'
        'Town'
        'City')
      TabOrder = 1
      OnClick = rgCityTypesClick
    end
    object rgAdminTypes: TRadioGroup
      Left = 8
      Top = 192
      Width = 177
      Height = 97
      Caption = 'Administrative Types'
      ItemIndex = 0
      Items.Strings = (
        'None'
        'Seat'
        'Capital')
      TabOrder = 2
      OnClick = rgAdminTypesClick
    end
    object btnCreateCity: TButton
      Left = 192
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Create City'
      TabOrder = 3
      OnClick = btnCreateCityClick
    end
  end
  object Panel1: TPanel
    Left = 88
    Top = 8
    Width = 601
    Height = 297
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    DesignSize = (
      601
      297)
    object Label7: TLabel
      Left = 24
      Top = 8
      Width = 20
      Height = 13
      Caption = 'City:'
    end
    object Label8: TLabel
      Left = 8
      Top = 32
      Width = 36
      Height = 13
      Caption = 'County:'
    end
    object Label9: TLabel
      Left = 16
      Top = 56
      Width = 28
      Height = 13
      Caption = 'State:'
    end
    object Label10: TLabel
      Left = 8
      Top = 80
      Width = 39
      Height = 13
      Caption = 'Country:'
    end
    object Label11: TLabel
      Left = 8
      Top = 120
      Width = 41
      Height = 13
      Caption = 'Address:'
    end
    object cbCities: TComboBox
      Left = 56
      Top = 8
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object cbCounties: TComboBox
      Left = 56
      Top = 32
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 1
    end
    object cbStates: TComboBox
      Left = 56
      Top = 56
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 2
    end
    object cbCountries: TComboBox
      Left = 56
      Top = 80
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 3
    end
    object cbAddresses: TComboBox
      Left = 56
      Top = 120
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 4
    end
    object memo1: TMemo
      Left = 208
      Top = 8
      Width = 385
      Height = 281
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 5
    end
  end
  object btnShow: TButton
    Left = 8
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Show'
    TabOrder = 0
    OnClick = btnShowClick
  end
  object btnCreate: TButton
    Left = 8
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 2
    OnClick = btnCreateClick
  end
  object btnAddCity: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Add City'
    TabOrder = 3
    OnClick = btnAddCityClick
  end
  object btnAddCounty: TButton
    Left = 8
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Add County'
    TabOrder = 6
    OnClick = btnAddCountyClick
  end
  object btnAddCountry: TButton
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Add Country'
    TabOrder = 7
    OnClick = btnAddCountryClick
  end
  object btnAddAddress: TButton
    Left = 8
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Add Address'
    TabOrder = 10
    OnClick = btnAddAddressClick
  end
end
