# encoding: UTF-8

require "net/http"
require "net/https"
require "json"

# token enviado pelo suporte
token = "codigo_alfanumerico_token"

# referência da nota - deve ser única para cada nota enviada
ref = "id_referencia_nota"

# endereço da api que deve ser usado conforme o ambiente: produção ou homologação
servidor_producao = "https://api.focusnfe.com.br/"
servidor_homologacao = "https://homologacao.focusnfe.com.br/"

# no caso do ambiente de envio ser em produção, utilizar servidor_producao
url_envio = servidor_homologacao + "v2/nfce/" + ref + "/email"

# altere os campos conforme a nota que será enviada
emails_destinatarios = {
  emails: ["email_01@acras.com.br", "email_02@acras.com.br", "email_03@acras.com.br"]
}
# criamos uma objeto uri para envio da nota
uri = URI(url_envio)

# também criamos um objeto da classe HTTP a partir do host da uri
http = Net::HTTP.new(uri.hostname, uri.port)

# aqui criamos um objeto da classe Post a partir da uri de requisição
requisicao = Net::HTTP::Post.new(uri.request_uri)

# adicionando o token à requisição
requisicao.basic_auth(token, '')

# convertemos os dados da nota para o formato JSON e adicionamos ao corpo da requisição
requisicao.body = emails_destinatarios.to_json

# no envio de notas em produção, é necessário utilizar o protocolo ssl
# para isso, basta retirar o comentário da linha abaixo
# http.use_ssl = true

# aqui enviamos a requisição ao servidor e obtemos a resposta
resposta = http.request(requisicao)

# imprimindo o código HTTP da resposta
puts "Código retornado pela requisição: " + resposta.code

# imprimindo o corpo da resposta
puts "Corpo da resposta: " + resposta.body
