object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 325
  Width = 546
  object conn: TFDConnection
    Params.Strings = (
      'Database=wk_teste'
      'User_Name=root'
      'Server=nicassio-pc'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Transaction = tran
    Left = 24
    Top = 16
  end
  object tran: TFDTransaction
    Connection = conn
    Left = 72
    Top = 16
  end
  object qryPedido: TFDQuery
    Connection = conn
    SQL.Strings = (
      'select '
      'p.id, p.cliente_id, p.valor_total, p.data_emissao,'
      'c.nome, c.cidade, c.uf '
      'from pedidos p'
      'inner join clientes c on c.id = p.cliente_id'
      'where p.id = :id')
    Left = 216
    Top = 64
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end>
    object qryPedidoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryPedidocliente_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'cliente_id'
      Origin = 'cliente_id'
    end
    object qryPedidovalor_total: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Precision = 20
      Size = 4
    end
    object qryPedidodata_emissao: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_emissao'
      Origin = 'data_emissao'
    end
    object qryPedidonome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 150
    end
    object qryPedidocidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cidade'
      Origin = 'cidade'
      ProviderFlags = []
      ReadOnly = True
      Size = 150
    end
    object qryPedidouf: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'uf'
      Origin = 'uf'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 2
    end
  end
  object qryPedidoProdutos: TFDQuery
    Connection = conn
    SQL.Strings = (
      'select '
      'pp.id, pp.pedido_id, pp.produto_id, '
      'pp.quantidade, pp.valor_unitario, pp.valor_total,'
      'p.descricao'
      'from pedidos_produtos pp'
      'inner join produtos p on p.id = pp.produto_id'
      'where pp.pedido_id = :id')
    Left = 232
    Top = 176
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end>
    object qryPedidoProdutosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryPedidoProdutospedido_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'pedido_id'
      Origin = 'pedido_id'
    end
    object qryPedidoProdutosproduto_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'produto_id'
      Origin = 'produto_id'
    end
    object qryPedidoProdutosquantidade: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object qryPedidoProdutosvalor_unitario: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_unitario'
      Origin = 'valor_unitario'
      Precision = 20
      Size = 4
    end
    object qryPedidoProdutosvalor_total: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Precision = 20
      Size = 4
    end
    object qryPedidoProdutosdescricao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'descricao'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
  end
  object command: TFDCommand
    Connection = conn
    CommandKind = skInsert
    Left = 344
    Top = 176
  end
  object qryPesquisarPedido: TFDQuery
    Connection = conn
    SQL.Strings = (
      'select '
      'p.id, p.cliente_id, p.valor_total, p.data_emissao,'
      'c.nome, c.cidade, c.uf '
      'from pedidos p'
      'inner join clientes c on c.id = p.cliente_id'
      'where p.data_emissao between :dt_ini and :dt_fim')
    Left = 88
    Top = 128
    ParamData = <
      item
        Name = 'DT_INI'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DT_FIM'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end>
    object qryPesquisarPedidoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryPesquisarPedidocliente_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'cliente_id'
      Origin = 'cliente_id'
    end
    object qryPesquisarPedidovalor_total: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      currency = True
      Precision = 20
      Size = 4
    end
    object qryPesquisarPedidodata_emissao: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_emissao'
      Origin = 'data_emissao'
    end
    object qryPesquisarPedidonome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 150
    end
    object qryPesquisarPedidocidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cidade'
      Origin = 'cidade'
      ProviderFlags = []
      ReadOnly = True
      Size = 150
    end
    object qryPesquisarPedidouf: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'uf'
      Origin = 'uf'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 2
    end
  end
end
