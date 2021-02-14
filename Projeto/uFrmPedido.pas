unit uFrmPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmSimples, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  FireDAC.Stan.StorageBin, Vcl.DBCtrls;

type
  TFrmPedido = class(TFrmSimples)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtCodigoCliente: TEdit;
    edtNomeCliente: TEdit;
    GroupBox2: TGroupBox;
    edtCodigoProduto: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtDescricao: TEdit;
    edtQuantidade: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtValorUnitario: TEdit;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    tblPedidoProduto: TFDMemTable;
    dsPedidoProduto: TDataSource;
    tblPedidoProdutoId: TIntegerField;
    tblPedidoProdutoDecricao: TStringField;
    tblPedidoProdutoQuantidade: TIntegerField;
    tblPedidoProdutoValorUnitario: TFloatField;
    tblPedidoProdutoValorTotal: TFloatField;
    btnGravar: TBitBtn;
    tblPedidoProdutoSeq: TAutoIncField;
    btnCancelar: TBitBtn;
    tblPedidoProdutoTotalVenda: TAggregateField;
    dbEditValorTotal: TDBEdit;
    Label7: TLabel;
    btnGravarPedido: TBitBtn;
    btnAbrirPedido: TBitBtn;
    btnCancelarPedido: TBitBtn;
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure edtCodigoProdutoChange(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnAbrirPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPedido: TFrmPedido;
  sequencial: integer;

implementation

{$R *.dfm}

uses uDm, uProduto, uFuncoes, uFrmLocalizarPedido;

procedure TFrmPedido.btnAbrirPedidoClick(Sender: TObject);
var
  frm: TFrmLocalizarPedido;
begin
  inherited;
  frm := TFrmLocalizarPedido.Create(Self);
  if (frm.ShowModal() = mrOk) then
  begin
    sequencial := 0;
    tblPedidoProduto.Close();
    tblPedidoProduto.Open();

    dm.qryPedido.Close();
    dm.qryPedidoProdutos.Close();
    dm.qryPedido.ParamByName('id').AsInteger := frm.pedidoId;
    dm.qryPedidoProdutos.ParamByName('id').AsInteger := frm.pedidoId;
    dm.qryPedido.Open();
    dm.qryPedidoProdutos.Open();

    edtCodigoCliente.Text := dm.qryPedido.FieldByName('cliente_id').AsString;
    edtNomeCliente.Text := dm.qryPedido.FieldByName('nome').AsString;
    dm.qryPedidoProdutos.First();
    while not dm.qryPedidoProdutos.Eof do
    begin
      tblPedidoProduto.Insert();
      tblPedidoProduto.FieldByName('Id').AsString := dm.qryPedidoProdutos.FieldByName('produto_id').AsString;
      tblPedidoProduto.FieldByName('Descricao').AsString := dm.qryPedidoProdutos.FieldByName('descricao').AsString;
      tblPedidoProduto.FieldByName('ValorUnitario').AsFloat := dm.qryPedidoProdutos.FieldByName('valor_unitario').AsFloat;
      tblPedidoProduto.FieldByName('Quantidade').AsString := dm.qryPedidoProdutos.FieldByName('quantidade').AsString;
      tblPedidoProduto.FieldByName('ValorTotal').AsFloat := tblPedidoProduto.FieldByName('ValorUnitario').AsFloat * tblPedidoProduto.FieldByName('Quantidade').AsInteger;
      tblPedidoProduto.Post();
      dm.qryPedidoProdutos.Next();
    end;

    edtCodigoProduto.Text := '';
    edtCodigoProdutoChange(edtCodigoProduto);
    if (edtCodigoProduto.CanFocus) then
      edtCodigoProduto.SetFocus();
  end;
  FreeAndNil(frm);
end;

procedure TFrmPedido.btnCancelarClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text := 'Informe o código do produto no campo ao lado';
  edtValorUnitario.Text := '0,00';
  edtQuantidade.Text := '0';
  edtCodigoProduto.Text := '';
  sequencial := 0;
end;

procedure TFrmPedido.btnCancelarPedidoClick(Sender: TObject);
var
  frm: TFrmLocalizarPedido;
begin
  inherited;
  frm := TFrmLocalizarPedido.Create(Self);
  if (frm.ShowModal() = mrOk) then
  begin
    if (fPergunta('Cancelar o pedido?')) then
      dm.cancelarPedido(frm.pedidoId);
  end;
  FreeAndNil(frm);
end;

procedure TFrmPedido.btnGravarClick(Sender: TObject);
begin
  inherited;
  if (not tblPedidoProduto.Active) then
    tblPedidoProduto.Active := true;

  if (edtCodigoProduto.Text <> '')
      and (edtDescricao.Text <> 'Produto não localizado')
      and (edtDescricao.Text <> 'Informe o código do produto no campo ao lado') then
  begin
      if (edtQuantidade.Text <> '0') and (StrToInt(edtQuantidade.Text) > 0) then
      begin
        if (edtValorUnitario.Text <> '0') and (StrToFloat(edtValorUnitario.Text) > 0) then
        begin
           if (sequencial = 0) then
             tblPedidoProduto.Insert()
           else
             tblPedidoProduto.Edit();

           tblPedidoProduto.FieldByName('Id').AsString := edtCodigoProduto.Text;
           tblPedidoProduto.FieldByName('Descricao').AsString := edtDescricao.Text;
           tblPedidoProduto.FieldByName('ValorUnitario').AsFloat := StrToFloat(edtValorUnitario.Text);
           tblPedidoProduto.FieldByName('Quantidade').AsString := edtQuantidade.Text;
           tblPedidoProduto.FieldByName('ValorTotal').AsFloat := tblPedidoProduto.FieldByName('ValorUnitario').AsFloat * tblPedidoProduto.FieldByName('Quantidade').AsInteger;
           tblPedidoProduto.Post();
           sequencial := 0;
           edtCodigoProduto.Text := '';
           edtCodigoProdutoChange(edtCodigoProduto);
           if (edtCodigoProduto.CanFocus) then
             edtCodigoProduto.SetFocus();
        end
        else
          pMensagemAtencao('O valor deve ser maior que zero');
      end
      else
        pMensagemAtencao('A quantidade deve ser maior que zero');
  end
  else
    pMensagemAtencao('Produto não informado');

end;

procedure TFrmPedido.btnGravarPedidoClick(Sender: TObject);
begin
  inherited;
  if (edtCodigoCliente.Text = '') or (edtNomeCliente.Text = 'Informe o código do cliente no campo ao lado') then
    pMensagemAtencao('Informe o cliente antes de salvar o pedido')
  else if (tblPedidoProduto.RecordCount = 0) then
    pMensagemAtencao('Informe os produtos antes de salvar o pedido')
  else
  begin
     if dm.inserirPedido(StrToInt(edtCodigoCliente.Text), dbEditValorTotal.Field.Value, tblPedidoProduto) then
     begin
       edtCodigoCliente.Text := '';
       edtCodigoProduto.Text := '';
       edtNomeCliente.Text := 'Informe o código do cliente no campo ao lado';
       edtDescricao.Text := 'Informe o código do produto no campo ao lado';
       edtValorUnitario.Text := '0,00';
       edtQuantidade.Text := '0';
       tblPedidoProduto.Close();
     end;
  end;
end;

procedure TFrmPedido.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = 13) then
  begin
    sequencial := tblPedidoProduto.FieldByName('Sequencial').AsInteger;
    edtCodigoProduto.Text := tblPedidoProduto.FieldByName('Id').AsString;
    edtDescricao.Text := tblPedidoProduto.FieldByName('Descricao').AsString;
    edtValorUnitario.Text := FormatFloat('#,##0.00', tblPedidoProduto.FieldByName('ValorUnitario').AsFloat);
    edtQuantidade.Text := tblPedidoProduto.FieldByName('Quantidade').AsString;
  end;
  if (key = 46) then
  begin
    if fPergunta('Confirma a remoção do produto selecionado?') then
    begin
      tblPedidoProduto.Delete();
    end;
  end;
end;

procedure TFrmPedido.edtCodigoClienteChange(Sender: TObject);
var
  nomeCliente : string;
begin
  inherited;
  btnCancelarPedido.Visible := false;
  btnAbrirPedido.Visible := false;
  try
    if (TEdit(Sender).Text <> '') then
    begin
       nomeCliente := dm.buscarNomeCliente(StrToInt(TEdit(Sender).Text));
       if (nomeCliente = '') then
         edtNomeCliente.Text := 'Cliente não localizado'
       else
         edtNomeCliente.Text := nomeCliente;
    end
    else
    begin
      edtNomeCliente.Text := 'Informe o código do cliente no campo ao lado';
      btnCancelarPedido.Visible := true;
      btnAbrirPedido.Visible := true;
    end;
  except
    on e: exception do
    begin
        ShowMessage('Não foi possível localizar o cliente');
    end;
  end;

end;

procedure TFrmPedido.edtCodigoProdutoChange(Sender: TObject);
var
  vProduto: TProduto;
begin
  inherited;
  try
    if (TEdit(Sender).Text <> '') then
    begin
       vProduto := dm.buscarProduto(StrToInt(TEdit(Sender).Text));
       if (vProduto = nil) or (vProduto.Descricao = '') then
       begin
         edtDescricao.Text := 'Produto não localizado';
         edtValorUnitario.Text := '0,00';
         edtQuantidade.Text := '0';
       end
       else
       begin
         edtDescricao.Text := vProduto.Descricao;
         edtValorUnitario.Text := FormatFloat('#,##0.00', vProduto.PrecoVenda);
         edtQuantidade.Text := '1';
       end;
    end
    else
    begin
      edtDescricao.Text := 'Informe o código do produto no campo ao lado';
      edtValorUnitario.Text := '0,00';
      edtQuantidade.Text := '0';
    end;
  except
    on e: exception do
    begin
        pMensagemAtencao('Não foi possível localizar o produto');
    end;
  end;
end;


end.
