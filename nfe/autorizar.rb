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
servidor_homologacao = "http://homologacao.acrasnfe.acras.com.br/"

# no caso do ambiente de envio ser em produção, utilizar servidor_producao
url_envio = servidor_homologacao + "v2/nfe?ref=" + ref

# altere os campos conforme a nota que será enviada
dados_da_nota = {
  "natureza_operacao":"Remessa",
  "data_emissao":"2017-11-30T12:00:00",
  "data_entrada_saida":"2017-11-3012:00:00",
  "tipo_documento":"1",
  "finalidade_emissao":"1",
  "cnpj_emitente":"51916585000125",
  "nome_emitente":"ACME LTDA",
  "nome_fantasia_emitente":"ACME LTDA",
  "logradouro_emitente":"R. Padre Natal Pigato",
  "numero_emitente":"100",
  "bairro_emitente":"Santa Felicidade",
  "municipio_emitente":"Curitiba",
  "uf_emitente":"PR",
  "cep_emitente":"82320030",
  "inscricao_estadual_emitente":"101942171617",
  "nome_destinatario":"NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL",
  "cpf_destinatario":"51966818092",
  "telefone_destinatario":"1196185555",
  "logradouro_destinatario":"Rua Sao Januario",
  "numero_destinatario":"99",
  "bairro_destinatario":"Crespo",
  "municipio_destinatario":"Manaus",
  "uf_destinatario":"AM",
  "pais_destinatario":"Brasil",
  "cep_destinatario":"69073178",
  "valor_frete":"0.0",
  "valor_seguro":"0",
  "valor_total":"47.23",
  "valor_produtos":"47.23",
  "modalidade_frete":"0",
  "items":[
    "numero_item":"1",
    "codigo_produto":"1232",
    "descricao":"Cartu00f5es de Visita",
    "cfop":"6923",
    "unidade_comercial":"un",
    "quantidade_comercial":"100",
    "valor_unitario_comercial":"0.4723",
    "valor_unitario_tributavel":"0.4723",
    "unidade_tributavel":"un",
    "codigo_ncm":"49111090",
    "quantidade_tributavel":"100",
    "valor_bruto":"47.23",
    "icms_situacao_tributaria":"400",
    "icms_origem":"0",
    "pis_situacao_tributaria":"07",
    "cofins_situacao_tributaria":"07"
  ]
}

# criamos uma objeto uri para envio da nota
uri_requisicao = URI(url_envio)

# também criamos um objeto da classe HTTP a partir do host da uri
http = Net::HTTP.new(uri_requisicao.hostname, uri_requisicao.port)

# aqui criamos um objeto da classe Post a partir da uri de requisição
requisicao = Net::HTTP::Post.new(uri_requisicao.request_uri)

# adicionando o token à requisição
requisicao.basic_auth(token, "")

# convertemos os dados da nota para o formato JSON e adicionamos ao corpo da requisição
requisicao.body = dados_da_nota.to_json

# no envio de notas em produção, é necessário utilizar o protocolo ssl
# para isso, basta retirar o comentário da linha abaixo
# http.use_ssl = true

# aqui enviamos a requisição ao servidor e obtemos a resposta
resposta = http.request(requisicao)

# imprimindo o código HTTP da resposta
puts "Código retornado pela requisição: " + resposta.code

# imprimindo o corpo da resposta
puts "Corpo da resposta: " + resposta.body