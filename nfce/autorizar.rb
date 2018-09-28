require "net/http"
require "net/https"
require "json"

class NfceAutorizar

  # token enviado pelo suporte
  @token = "codigo_alfanumerico_token"

  # referência da nota - deve ser única para cada nota enviada
  @ref = "id_referencia_nota"

  # endereço da api que deve ser usado conforme o ambiente: produção ou homologação
  @@servidor_producao = "https://api.focusnfe.com.br/"
  @@servidor_homologacao = "http://homologacao.acrasnfe.acras.com.br/"

  # no caso do ambiente de envio ser em produção, utilizar @@servidor_producao
  @url_envio = @@servidor_homologacao + "v2/nfce?ref=" + @ref

  # altere os campos conforme a nota que será enviada
  @dados_da_nota = {
    "cnpj_emitente":"05953016000132",
    "data_emissao":"2017-12-06 14:45:10",
    "indicador_inscricao_estadual_destinatario":"9",
    "modalidade_frete":"9",
    "local_destino":"1",
    "presenca_comprador":"1",
    "natureza_operacao":"VENDA AO CONSUMIDOR",
    "items":[
      "numero_item":"1",
      "codigo_ncm":"62044200",
      "quantidade_comercial":"1.00",
      "quantidade_tributavel":"1.00",
      "cfop":"5102",
      "valor_unitario_tributavel":"79.00",
      "valor_unitario_comercial":"79.00",
      "valor_desconto":"0.00",
      "descricao":"NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL",
      "codigo_produto":"251887",
      "icms_origem":"0",
      "icms_situacao_tributaria":"102",
      "unidade_comercial":"un",
      "unidade_tributavel":"un",
      "valor_total_tributos":"24.29"
    ],
    "formas_pagamento":[
      "forma_pagamento":"03",
      "valor_pagamento":"79.00",
      "nome_credenciadora":"Cielo",
      "bandeira_operadora":"02",
      "numero_autorizacao":"R07242"
    ]
 }
  
  # criamos uma objeto uri para envio da nota
  @uri_requesicao = URI(@url_envio)

  # também criamos um objeto da classe HTTP a partir do host da uri
  @http = Net::HTTP.new(@uri_requesicao.hostname)
  
  # aqui criamos um objeto da classe Post a partir da uri de requisição
  @requisicao = Net::HTTP::Post.new(@uri_requesicao)

  # adicionando o token à requisição
  @requisicao.basic_auth(@token, '')

  # convertemos os dados da nota para o formato JSON e adicionamos ao corpo da requisição
  @requisicao.body = @dados_da_nota.to_json

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