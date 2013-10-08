Instruções para execução do laboratório:

1. Criar uma classe “sender genérico”. A classe deve manter uma conexão aberta e disponibilizar um método 
   de envio de mensagens. Esse método recebe como parâmetro o texto a ser inserido na mensagem e faz o envio. 
   A classe também deve oferecer um método para liberar os recursos utilizados.

2. Criar uma outra classe para utilizar o sender genérico. Esta classe deve criar uma lista de mensagens a 
   serem transmitidas e utilizar o sender genérico para envia-las. Após o envio de todas as mensagens, deve 
   utilizar o método apropriado do sender genérico para liberação dos recursos.

3. Criar um consumidor síncrono que permaneça em loop, aguardando e consumindo as mensagens.

----
 * https://sites.google.com/site/professorheliomarci/4-egc-na10-g0528
 * add jar gf-client.jar: usar jar que esta na pasta C:\Arquivos de programas\glassfish-3.1.2.2\glassfish\lib
 * iniciar servidor glassfish: https://sites.google.com/site/professorheliomarci/glassfish
  * alterar porta padrão do servidor glassfish no caso de porta em utilização: http://www.srikanthtechnologies.com/blog/java/changeglassfishport.aspx
 * seguir: integracao-si-3-jms-glassfish.ppt

