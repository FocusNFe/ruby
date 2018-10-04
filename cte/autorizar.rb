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
url_envio = servidor_homologacao + "v2/cte?ref=" + ref

# altere os campos conforme a nota que será enviada
cte = {
  bairro_emitente: "Sao Cristovao",
  bairro_tomador: "Bacacheri",
  cep_emitente: "99880077",
  cep_tomador: "88991188",
  cfop: "5353",
  cnpj_emitente: "51916585000125",
  cnpj_tomador: "51966818092777",
  codigo_municipio_emitente: "2927408",
  codigo_municipio_envio: "5200050",
  codigo_municipio_fim: "3100104",
  codigo_municipio_inicio: "5200050",
  codigo_municipio_tomador: "4106902",
  codigo_pais_tomador: "1058",
  complemento_emitente: "Andar 19 - sala 23",
  data_emissao: "2018-06-18T09:17:00",
  descricao_servico: "Descricao do seu servico aqui",
  documentos_referenciados: [
    {  
      data_emissao: "2018-06-10",
      numero: "1",
      serie: "1",
      subserie: "1",
      valor: "1.00"
    }
  ]
  funcionario_emissor: "Nome do funcionario que fez a emissao",
  icms_aliquota: "17.00",
  icms_base_calculo: "1.00",
  icms_situacao_tributaria: "00",
  icms_valor: "0.17",
  indicador_inscricao_estadual_tomador: "9",
  inscricao_estadual_emitente: "12345678",
  logradouro_emitente: "Aeroporto Internacional de Salvador",
  logradouro_tomador: "Rua Joao Dalegrave",
  modal: "02",
  municipio_emitente: "Salvador",
  municipio_envio: "Abadia de Goias",
  municipio_fim: "Abadia dos Dourados",
  municipio_inicio: "Abadia de Goias",
  municipio_tomador: "Curitiba",
  natureza_operacao: "PREST. DE SERV. TRANSPORTE A ESTAB. COMERCIAL",
  nome_emitente: "ACME LTDA",
  nome_fantasia_emitente: "ACME",
  nome_fantasia_tomador: "Nome do tomador do servico aqui",
  nome_tomador: "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL",
  numero_emitente: "S/N",
  numero_fatura: "1",
  numero_tomador: "1",
  pais_tomador: "BRASIL",
  quantidade: "1.00",
  seguros_carga: [
    {
      nome_seguradora: "Nome da seguradora aqui",
      numero_apolice: "12345",
      responsavel_seguro: 4
    }
  ],
  telefone_emitente: "4133336666",
  tipo_documento: 0,
  tipo_servico: 6,
  uf_emitente: "BA",
  uf_envio: "GO",
  uf_fim: "MG",
  uf_inicio: "GO",
  uf_tomador: "PR",
  valor_desconto_fatura: "0.00",
  valor_inss: "0.10",
  valor_liquido_fatura: "1.00",
  valor_original_fatura: "1.00",
  valor_receber: "1.00",
  valor_total: "1.00",
  valor_total_tributos: "0.00"
}

# criamos uma objeto uri para envio da nota
uri = URI(url_envio)

# também criamos um objeto da classe HTTP a partir do host da uri
http = Net::HTTP.new(uri.hostname, uri.port)

# aqui criamos um objeto da classe Post a partir da uri de requisição
requisicao = Net::HTTP::Post.new(uri.request_uri)

# adicionando o token à requisição
requisicao.basic_auth(token, "")

# convertemos os dados da nota para o formato JSON e adicionamos ao corpo da requisição
requisicao.body = cte.to_json

# no envio de notas em produção, é necessário utilizar o protocolo ssl
# para isso, basta retirar o comentário da linha abaixo
# http.use_ssl = true

# aqui enviamos a requisição ao servidor e obtemos a resposta
resposta = http.request(requisicao)

# imprimindo o código HTTP da resposta
puts "Código retornado pela requisição: " + resposta.code

# imprimindo o corpo da resposta
puts "Corpo da resposta: " + resposta.body