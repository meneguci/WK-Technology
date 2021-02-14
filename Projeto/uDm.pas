unit uDm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Dialogs, uProduto;

type
  Tdm = class(TDataModule)
    conn: TFDConnection;
    tran: TFDTransaction;
    qryPedido: TFDQuery;
    qryPedidoProdutos: TFDQuery;
    command: TFDCommand;
    qryPedidoid: TFDAutoIncField;
    qryPedidocliente_id: TIntegerField;
    qryPedidovalor_total: TFMTBCDField;
    qryPedidodata_emissao: TDateTimeField;
    qryPedidonome: TStringField;
    qryPedidocidade: TStringField;
    qryPedidouf: TStringField;
    qryPedidoProdutosid: TFDAutoIncField;
    qryPedidoProdutospedido_id: TIntegerField;
    qryPedidoProdutosproduto_id: TIntegerField;
    qryPedidoProdutosquantidade: TIntegerField;
    qryPedidoProdutosvalor_unitario: TFMTBCDField;
    qryPedidoProdutosvalor_total: TFMTBCDField;
    qryPedidoProdutosdescricao: TStringField;
    qryPesquisarPedido: TFDQuery;
    qryPesquisarPedidoid: TFDAutoIncField;
    qryPesquisarPedidocliente_id: TIntegerField;
    qryPesquisarPedidovalor_total: TFMTBCDField;
    qryPesquisarPedidodata_emissao: TDateTimeField;
    qryPesquisarPedidonome: TStringField;
    qryPesquisarPedidocidade: TStringField;
    qryPesquisarPedidouf: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    function criarQueryTemp(sql: string): TFDQuery;
  public
    function buscarNomeCliente(codigo: Integer): string;
    function buscarProduto(codigo: Integer): TProduto;
    function inserirPedido(codigoCliente: integer; valorTotal: double; tblProdutos: TFDMemTable): boolean;
    function cancelarPedido(pedidoId: integer): boolean;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uFuncoes;

{$R *.dfm}

function Tdm.buscarNomeCliente(codigo: Integer): string;
var
  qry: TFDQuery;
begin
  qry :=  criarQueryTemp('select nome from clientes where id = :id');
  qry.ParamByName('id').Value := codigo;
  qry.Open();

  Result := qry.FieldByName('nome').AsString;
  qry.Close();
  FreeAndNil(qry);
end;

function Tdm.buscarProduto(codigo: Integer): TProduto;
var
  qry: TFDQuery;
begin
  qry :=  criarQueryTemp('select id, descricao, preco_venda from produtos where id = :id');
  qry.ParamByName('id').Value := codigo;
  qry.Open();

  Result := TProduto.Create(qry.FieldByName('id').AsInteger,
                            qry.FieldByName('descricao').AsString,
                            qry.FieldByName('preco_venda').AsFloat);
  qry.Close();
  FreeAndNil(qry);
end;


function Tdm.criarQueryTemp(sql: string): TFDQuery;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := conn;
  qry.SQL.Text := sql;
  Result := qry;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  try
    conn.Open();
  except
    on e: exception do
    begin
        ShowMessage(e.Message);
    end;
  end;


end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  if conn.Connected then
    conn.Close();
end;

function Tdm.inserirPedido(codigoCliente: integer; valorTotal: double; tblProdutos: TFDMemTable): boolean;
var
  pedidoId: integer;
begin
  tran.StartTransaction();
  Result := false;
  try
    command.CommandText.Text := 'INSERT INTO pedidos '+
                      '('+
                      'cliente_id,'+
                      'data_emissao,'+
                      'valor_total)'+
                      ' VALUES '+
                      '(' +
                      ':cliente_id,'+
                      'CURRENT_TIMESTAMP(),'+
                      ':valor_total)';
    command.ParamByName('cliente_id').AsInteger := codigoCliente;
    //command.ParamByName('data_emissao').AsDateTime := codigoCliente;
    command.ParamByName('valor_total').AsFloat := valorTotal;
    command.Execute();
    pedidoId := conn.GetLastAutoGenValue('');
    command.CommandText.Text := 'INSERT INTO pedidos_produtos '+
                      '(pedido_id,'+
                      'produto_id,'+
                      'quantidade,'+
                      'valor_unitario,'+
                      'valor_total)'+
                      ' VALUES '+
                      '(:pedido_id,'+
                      ':produto_id,'+
                      ':quantidade,'+
                      ':valor_unitario,'+
                      ':valor_total)';
    tblProdutos.First();
    while not tblProdutos.Eof do
    begin
      command.ParamByName('pedido_id').AsInteger := pedidoId;
      command.ParamByName('produto_id').AsInteger := tblProdutos.FieldByName('Id').AsInteger;
      command.ParamByName('quantidade').AsInteger := tblProdutos.FieldByName('Quantidade').AsInteger;
      command.ParamByName('valor_unitario').AsFloat := tblProdutos.FieldByName('ValorUnitario').AsInteger;
      command.ParamByName('valor_total').AsFloat := tblProdutos.FieldByName('ValorTotal').AsInteger;
      command.Execute();
      tblProdutos.Next();
    end;

    tran.Commit();
    Result := true;
  except
    tran.Rollback();
    pMensagemErro('Não foi possível salvar o pedido.')
  end;
end;

function Tdm.cancelarPedido(pedidoId: integer): boolean;
begin
  tran.StartTransaction();
  Result := false;
  try
    command.CommandText.Text := 'DELETE FROM pedidos_produtos WHERE pedido_id = :id';
    command.ParamByName('id').AsInteger := pedidoId;
    command.Execute();

    command.CommandText.Text := 'DELETE FROM pedidos WHERE id = :id';
    command.ParamByName('id').AsInteger := pedidoId;
    command.Execute();

    tran.Commit();
    Result := true;
  except
    tran.Rollback();
    pMensagemErro('Não foi possível salvar o pedido.')
  end;
end;

end.
