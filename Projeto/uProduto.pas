unit uProduto;

interface
  type
    TProduto = class
  private
    _codigo: integer;
    _descricao: string;
    _precoVenda: double;
  public
    constructor Create( codigo: integer; descricao: string; precoVenda: double);
  published
    property Codigo: integer read _codigo write _codigo;
    property Descricao: string read _descricao write _descricao;
    property PrecoVenda: double read _precoVenda write _precoVenda;
  end;
implementation

{ TProduto }

constructor TProduto.Create(codigo: integer; descricao: string;
  precoVenda: double);
begin
  _codigo := codigo;
  _descricao := descricao;
  _precoVenda := precoVenda;
end;

end.
