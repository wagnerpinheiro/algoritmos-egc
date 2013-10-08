Projeto: Integracao de Arquivos e BD

Objetivos: 

PARTE A - Criar classes para ler informacoes de arquivos CSV e inserir em um BD Derby.

PARTE B - Criar classes para ler os dados do BD Derby, gerar entidades (objetos) com estes dados
          e grava-los em disco, usando objetos serializados.

Considerações gerais:
- Procure criar classes e metodos coesos.
- Faca o tratamento das excecoes Java adequadamente.
- Quando possivel, crie classes e metodos utilitarios (classes com operacoes basicas que sao 
  reutilizadas por outras classes).

================================================================================
PARTE A: INTEGRACAO ARQUIVOS TEXTO -> BD

--------------------------------------------------------------------------------
1. Criacao da base de dados (esquema)

- Na aba "Serviços", clicar com o botao direito sobre o item "Java DB" e escolher a opcao
  "Criar banco de dados".
- Informar os seguintes dados:
  * Nome do BD: Pedidos
  * Nome do usuário: aluno
  * Senha: aluno
- Apos a confirmacao, o BD Pedidos deve aparecer na lista de BDs, no item "Java DB".
- Clicar sobre o nome do BD Pedidos, em "java DB" e escolher "conectar".
- Uma conexao sera aberta com o BD Pedidos e deve aparecer na relacao de conexoes.

--------------------------------------------------------------------------------
2. Criacao das tabelas

- Clicar com o botao direito na conexao e escolher a opcao "Executar comando".
- Copiar o conteudo do arquivo cria-tabelas.txt na janela aberta (passo anterior) e executar.
- As instrucoes do cria-tabelas.txt devem criar as tabelas da aplicacao de pedidos, 
  incluindo as chaves e restricoes.
- Segue abaixo a relacao de tabelas criadas, para conferencia:
  * Cliente
    - Colunas = id_cliente, nome, cpf e endereco
    - PK = id_cliente 
    - Restricao unique(cpf) 
  * Pedido
    - Colunas = id_pedido, id_cliente e data_criacao
    - PK = id_pedido
  * PedidoItem
    - Colunas = id_pedido_item, id_pedido, id_produto, quantidade
    - PK = id_pedido_item 
    - Restricao unique(id_pedido,id_produto)
  * Produto
    - Colunas = id_produto, fornecedor, catetoria, descricao
    - PK = id_produto 
    - Restricao unique(id_fornecedor, categoria, descricao)

--------------------------------------------------------------------------------
3. Criacao das classes para carregar dados de clientes, produtos e pedidos

- Utilizando as classes TesteArquivo e Cliente como exemplo, criar classes para ler arquivos
  CSV (arquivos texto com colunas delimitadas por tabulacoes) e gerar listas de objetos.
- Fazer isso para carregar, a partir de arquivos, listas de clientes, produtos e pedidos.
- Considere que cada lista esta em um arquivo.

--------------------------------------------------------------------------------
4. Criacao das classes para insercao dos objetos na base de dados

- Utilizando a classe TesteDB como exemplo, criar classes com metodos que recebem listas de
  entidades como parametro e inserem os dados nas devidas tabelas do BD. Por exemplo, um metodo
  para insercao de clientes no BD deve receber como parametro uma lista de clientes e inserir
  esses clientes no BD.

--------------------------------------------------------------------------------
5. Execucao

- Utilizando as classes criadas nos passos anteriores, criar um programa para carregar as 
  listas de clientes, produtos e pedidos de arquivos CSV e inserir os mesmos no BD.

================================================================================
PARTE B: INTEGRACAO BD -> OBJETOS SERIALIZADOS


