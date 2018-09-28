require "net/http"
require "net/https"
require "json"

class NfseAutorizar

  # token enviado pelo suporte
  @token = "codigo_alfanumerico_token"

  # referência da nota - deve ser única para cada nota enviada
  @ref = "id_referencia_nota"

  # endereço da api que deve ser usado conforme o ambiente: produção ou homologação
  @@servidor_producao = "https://api.focusnfe.com.br/"
  @@servidor_homologacao = "http://homologacao.acrasnfe.acras.com.br/"

  # no caso do ambiente de envio ser em produção, utilizar @@servidor_producao
  @url_envio = @@servidor_homologacao + "v2/nfse?ref=" + @ref

  # altere os campos conforme a nota que será enviada
  @dados_da_nota = {  
    "data_emissao":"2017-09-21T22:15:00",
    "prestador":{  
       "cnpj":"18765499000199",
       "inscricao_municipal":"12345",
       "codigo_municipio":"3516200"
    },
    "tomador":{  
       "cnpj":"07504505000132",
       "razao_social":"Acras Tecnologia da Informação LTDA",
       "email":"contato@acras.com.br",
       "endereco":{  
          "logradouro":"Rua Dias da Rocha Filho",
          "numero":"999",
          "complemento":"Prédio 04 - Sala 34C",
          "bairro":"Alto da XV",
          "codigo_municipio":"4106902",
          "uf":"PR",
          "cep":"80045165"
       }
    },
    "servico":{  
       "aliquota":3,
       "discriminacao":"Nota fiscal referente a serviços prestados",
       "iss_retido":"false",
       "item_lista_servico":"0107",
       "codigo_tributario_municipio": "620910000",
       "valor_servicos":1.0
    }
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