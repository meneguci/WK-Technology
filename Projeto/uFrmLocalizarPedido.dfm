inherited FrmLocalizarPedido: TFrmLocalizarPedido
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Localizar Pedido'
  ClientHeight = 324
  ClientWidth = 613
  Color = clWhite
  Position = poDesktopCenter
  ExplicitWidth = 619
  ExplicitHeight = 353
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 613
    Height = 65
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    ExplicitTop = -6
    object Label1: TLabel
      Left = 14
      Top = 12
      Width = 51
      Height = 13
      Caption = 'Data In'#237'cio'
    end
    object Label2: TLabel
      Left = 173
      Top = 12
      Width = 42
      Height = 13
      Caption = 'Data Fim'
    end
    object BitBtn1: TBitBtn
      Left = 316
      Top = 28
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object dtInicio: TDateTimePicker
      Left = 14
      Top = 31
      Width = 137
      Height = 21
      Date = 44241.000000000000000000
      Time = 0.824470532410487000
      TabOrder = 1
    end
    object dtFim: TDateTimePicker
      Left = 173
      Top = 31
      Width = 137
      Height = 21
      Date = 44241.000000000000000000
      Time = 0.824470532410487000
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 280
    Width = 613
    Height = 44
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object btnSelecionar: TBitBtn
      Left = 512
      Top = 6
      Width = 89
      Height = 32
      Caption = 'Selecionar'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnSelecionarClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 65
    Width = 613
    Height = 215
    Align = alClient
    DataSource = dsPesquisar
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'nome'
        Title.Caption = 'Cliente'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'data_emissao'
        Title.Caption = 'Data Emiss'#227'o'
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_total'
        Title.Caption = 'Valor Total'
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cidade'
        Title.Caption = 'Cidade'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'uf'
        Title.Caption = 'UF'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'cliente_id'
        Visible = False
      end>
  end
  object dsPesquisar: TDataSource
    DataSet = dm.qryPesquisarPedido
    Left = 448
    Top = 88
  end
end
