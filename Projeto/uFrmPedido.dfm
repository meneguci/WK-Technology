inherited FrmPedido: TFrmPedido
  Caption = 'WKTeste - Pedido'
  ClientHeight = 568
  ClientWidth = 691
  Color = clBtnHighlight
  Position = poDesktopCenter
  ExplicitWidth = 707
  ExplicitHeight = 607
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 691
    Height = 64
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object btnGravarPedido: TBitBtn
      Left = 592
      Top = 5
      Width = 89
      Height = 56
      Caption = 'Gravar o pedido'
      TabOrder = 0
      WordWrap = True
      OnClick = btnGravarPedidoClick
    end
    object btnAbrirPedido: TBitBtn
      Left = 497
      Top = 5
      Width = 89
      Height = 56
      Caption = 'Abrir um pedido'
      TabOrder = 1
      WordWrap = True
      OnClick = btnAbrirPedidoClick
    end
    object btnCancelarPedido: TBitBtn
      Left = 402
      Top = 5
      Width = 89
      Height = 56
      Caption = 'Cancelar um pedido'
      TabOrder = 2
      WordWrap = True
      OnClick = btnCancelarPedidoClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 64
    Width = 691
    Height = 80
    Align = alTop
    Caption = 'Cliente'
    TabOrder = 1
    ExplicitTop = 49
    object Label1: TLabel
      Left = 16
      Top = 21
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 127
      Top = 21
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object edtCodigoCliente: TEdit
      Left = 16
      Top = 40
      Width = 97
      Height = 21
      Alignment = taCenter
      NumbersOnly = True
      TabOrder = 0
      OnChange = edtCodigoClienteChange
    end
    object edtNomeCliente: TEdit
      Left = 127
      Top = 40
      Width = 458
      Height = 21
      TabStop = False
      Alignment = taCenter
      Color = clInactiveCaption
      ReadOnly = True
      TabOrder = 1
      Text = 'Informe o c'#243'digo do cliente no campo ao lado'
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 144
    Width = 691
    Height = 120
    Align = alTop
    Caption = 'Produto'
    TabOrder = 2
    ExplicitTop = 123
    object Label3: TLabel
      Left = 16
      Top = 21
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label4: TLabel
      Left = 127
      Top = 21
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label5: TLabel
      Left = 125
      Top = 69
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object Label6: TLabel
      Left = 191
      Top = 69
      Width = 64
      Height = 13
      Caption = 'Valor Unit'#225'rio'
    end
    object edtCodigoProduto: TEdit
      Left = 16
      Top = 40
      Width = 97
      Height = 21
      Alignment = taCenter
      NumbersOnly = True
      TabOrder = 0
      OnChange = edtCodigoProdutoChange
    end
    object edtDescricao: TEdit
      Left = 127
      Top = 40
      Width = 458
      Height = 21
      TabStop = False
      Alignment = taCenter
      Color = clInactiveCaption
      ReadOnly = True
      TabOrder = 1
      Text = 'Informe o c'#243'digo do produto no campo ao lado'
    end
    object edtQuantidade: TEdit
      Left = 125
      Top = 86
      Width = 56
      Height = 21
      Alignment = taCenter
      NumbersOnly = True
      TabOrder = 2
    end
    object edtValorUnitario: TEdit
      Left = 191
      Top = 86
      Width = 102
      Height = 21
      Alignment = taCenter
      TabOrder = 3
    end
    object btnGravar: TBitBtn
      Left = 299
      Top = 84
      Width = 75
      Height = 25
      Caption = 'Gravar'
      TabOrder = 4
      OnClick = btnGravarClick
    end
    object btnCancelar: TBitBtn
      Left = 380
      Top = 84
      Width = 75
      Height = 25
      Caption = 'Limpar'
      TabOrder = 5
      OnClick = btnCancelarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 519
    Width = 691
    Height = 49
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 3
    object Label7: TLabel
      Left = 472
      Top = 15
      Width = 49
      Height = 20
      Caption = 'Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbEditValorTotal: TDBEdit
      Left = 536
      Top = 12
      Width = 129
      Height = 27
      Color = clInfoBk
      DataField = 'TotalVenda'
      DataSource = dsPedidoProduto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 264
    Width = 691
    Height = 255
    Align = alClient
    DataSource = dsPedidoProduto
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'Sequencial'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'Id'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        ReadOnly = True
        Width = 375
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Quantidade'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorUnitario'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorTotal'
        ReadOnly = True
        Visible = True
      end>
  end
  object tblPedidoProduto: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 488
    Top = 320
    object tblPedidoProdutoSeq: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'Sequencial'
    end
    object tblPedidoProdutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
    end
    object tblPedidoProdutoDecricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Size = 2500
    end
    object tblPedidoProdutoQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object tblPedidoProdutoValorUnitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'ValorUnitario'
      currency = True
    end
    object tblPedidoProdutoValorTotal: TFloatField
      DisplayLabel = 'Valor Total'
      FieldName = 'ValorTotal'
      currency = True
    end
    object tblPedidoProdutoTotalVenda: TAggregateField
      FieldName = 'TotalVenda'
      Active = True
      currency = True
      DisplayName = ''
      Expression = 'SUM(ValorTotal)'
    end
  end
  object dsPedidoProduto: TDataSource
    DataSet = tblPedidoProduto
    Left = 432
    Top = 368
  end
end
