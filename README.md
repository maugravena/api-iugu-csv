# README

- Ruby 3.2.0
- Rails 8.0.2

## Para rodar a app localmente

```
bundle install
```

```
bundle exec rspec
```

```
bundle exec rails s
```

## Para rodar a app com Docker

Criar imagem
```
docker image build -t api_iugu .
```

Executar modo interativo para entra no bash do container
```
docker run -it -p 3000:3000 -v "$PWD":/app api_iugu bash
```

Instalar dependencias
```
bundle install
```

Executar testes
```
rspec
```

Subir app
```
rails s -b 0.0.0.0
```

## Curl para requisição

```
curl --request POST \
  --url http://localhost:3000/purchases/export_csv \
  --header 'Content-Type: application/json' \
  --header 'User-Agent: insomnia/10.3.1' \
  --data '{
  "data":[
    {
      "id":"TX001",
      "bandeira":"VISA",
      "valor_total":732.48,
      "qtd_parcelas":6,
      "data_compra":"2025-04-12",
      "cnpj_lojista":"12.345.678/0001-01",
      "parcelas_detalhadas":[
        {
          "parcela":1,
          "valor":122.08,
          "data_liquidacao":"2025-04-17"
        },
        {
          "parcela":2,
          "valor":122.08,
          "data_liquidacao":"2025-05-17"
        },
        {
          "parcela":3,
          "valor":122.08,
          "data_liquidacao":"2025-06-17"
        },
        {
          "parcela":4,
          "valor":122.08,
          "data_liquidacao":"2025-07-17"
        },
        {
          "parcela":5,
          "valor":122.08,
          "data_liquidacao":"2025-08-17"
        },
        {
          "parcela":6,
          "valor":122.08,
          "data_liquidacao":"2025-09-17"
        }
      ]
    },
    {
      "id":"TX002",
      "bandeira":"MASTER",
      "valor_total":991.10,
      "qtd_parcelas":10,
      "data_compra":"2025-04-10",
      "cnpj_lojista":"98.765.432/0001-99",
      "parcelas_detalhadas":[
        {
          "parcela":1,
          "valor":99.11,
          "data_liquidacao":"2025-04-17"
        },
        {
          "parcela":2,
          "valor":99.11,
          "data_liquidacao":"2025-05-17"
        },
        {
          "parcela":3,
          "valor":99.11,
          "data_liquidacao":"2025-06-17"
        },
        {
          "parcela":4,
          "valor":99.11,
          "data_liquidacao":"2025-07-17"
        },
        {
          "parcela":5,
          "valor":99.11,
          "data_liquidacao":"2025-08-17"
        },
        {
          "parcela":6,
          "valor":99.11,
          "data_liquidacao":"2025-09-17"
        },
        {
          "parcela":7,
          "valor":99.11,
          "data_liquidacao":"2025-10-17"
        },
        {
          "parcela":8,
          "valor":99.11,
          "data_liquidacao":"2025-11-17"
        },
        {
          "parcela":9,
          "valor":99.11,
          "data_liquidacao":"2025-12-17"
        },
        {
          "parcela":10,
          "valor":99.11,
          "data_liquidacao":"2026-01-17"
        }
      ]
    },
    {
      "id":"TX003",
      "bandeira":"VISA",
      "valor_total":520.00,
      "qtd_parcelas":1,
      "data_compra":"2025-04-09",
      "cnpj_lojista":"11.222.333/0001-44"
    },
    {
      "id":"TX004",
      "bandeira":"MASTER",
      "valor_total":928.00,
      "qtd_parcelas":1,
      "data_compra":"2025-04-10",
      "cnpj_lojista":"98.765.432/0001-99"
    },
    {
      "id":"TX004",
      "bandeira":"VISA",
      "valor_total":875.97,
      "qtd_parcelas":3,
      "data_compra":"2025-04-13",
      "cnpj_lojista":"12.345.678/0001-01",
      "parcelas_detalhadas":[
        {
          "parcela":1,
          "valor":291.99,
          "data_liquidacao":"2025-04-17"
        },
        {
          "parcela":2,
          "valor":291.99,
          "data_liquidacao":"2025-05-17"
        },
        {
          "parcela":3,
          "valor":291.99,
          "data_liquidacao":"2025-06-17"
        }
      ]
    }
  ]
}'
```
