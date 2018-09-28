require "net/http"
require "net/https"
require "json"

class NfseCancelar

  # token enviado pelo suporte
  @token = "codigo_alfanumerico_token"

  # referência da nota - deve ser única para cada nota enviada
  @ref = "id_referencia_nota"

  # endereço da api que deve ser usado conforme o ambiente: produção ou homologação
  @@servidor_producao = "https://api.focusnfe.com.br/"
  @@servidor_homologacao = "http://homologacao.acrasnfe.acras.com.br/"

  # no caso do ambiente de envio ser em produção, utilizar @@servidor_producao
  @url_envio = @@servidor_homologacao + "v2/nfse/" + @ref

  # altere os campos conforme a nota que será enviada
  @justificativa_cancelamento = {  
    "justificativa": "Informe aqui a sua justificativa para realizar o cancelamento da NFSe."
  }
  
  # criamos uma objeto uri para envio da nota
  @uri_requesicao = URI(@url_envio)

  # também criamos um objeto da classe HTTP a partir do host da uri
  @http = Net::HTTP.new(@uri_requesicao.hostname)
  
  # aqui criamos um objeto da classe Post a partir da uri de requisição
  @requisicao = Net::HTTP::Delete.new(@uri_requesicao)

  # adicionando o token à requisição
  @requisicao.basic_auth(@token, '')

  # convertemos a hash de justificativa do cancelamento para o formato JSON e adicionamos ao corpo da requisição
  @requisicao.body = @justificativa_cancelamento.to_json

  # no envio de notas em produção, é necessário utilizar o protocolo ssl
  # para isso, basta retirar o comentário da linha abaixo
  # @http.use_ssl = true

  # aqui enviamos a requisição ao servidor e obtemos a resposta
  @resposta = @http.request(@requisicao)

  # imprimindo o código HTTP da resposta
  puts "Código retornado pela requisição: " + @resposta.code

  # imprimindo o corpo da resposta
  puts "Corpo da resposta: " + @resposta.body

end