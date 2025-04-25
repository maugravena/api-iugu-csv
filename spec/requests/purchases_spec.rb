require 'rails_helper'

RSpec.describe '/purchases', type: :request do
  describe 'POST /purchases/export_csv' do
    let(:payload) do
      [
        {
          id: "TX001",
          bandeira: "VISA",
          valor_total: 732.48,
          qtd_parcelas: 6,
          data_compra: "2025-04-12",
          cnpj_lojista: "12.345.678/0001-01",
          parcelas_detalhadas: [
            { parcela: 1, valor: 122.08, data_liquidacao: "2025-04-17" },
            { parcela: 2, valor: 122.08, data_liquidacao: "2025-05-17" },
            { parcela: 3, valor: 122.08, data_liquidacao: "2025-06-17" },
            { parcela: 4, valor: 122.08, data_liquidacao: "2025-07-17" },
            { parcela: 5, valor: 122.08, data_liquidacao: "2025-08-17" },
            { parcela: 6, valor: 122.08, data_liquidacao: "2025-09-17" }
          ]
        },
        {
          id: "TX002",
          bandeira: "MASTER",
          valor_total: 991.1,
          qtd_parcelas: 10,
          data_compra: "2025-04-10",
          cnpj_lojista: "98.765.432/0001-99",
          parcelas_detalhadas: [
            { parcela: 1, valor: 99.11, data_liquidacao: "2025-04-17" },
            { parcela: 2, valor: 99.11, data_liquidacao: "2025-05-17" },
            { parcela: 3, valor: 99.11, data_liquidacao: "2025-06-17" },
            { parcela: 4, valor: 99.11, data_liquidacao: "2025-07-17" },
            { parcela: 5, valor: 99.11, data_liquidacao: "2025-08-17" },
            { parcela: 6, valor: 99.11, data_liquidacao: "2025-09-17" },
            { parcela: 7, valor: 99.11, data_liquidacao: "2025-10-17" },
            { parcela: 8, valor: 99.11, data_liquidacao: "2025-11-17" },
            { parcela: 9, valor: 99.11, data_liquidacao: "2025-12-17" },
            { parcela: 10, valor: 99.11, data_liquidacao: "2026-01-17" }
          ]
        },
        {
          id: "TX003",
          bandeira: "VISA",
          valor_total: 928.00,
          qtd_parcelas: 1,
          data_compra: "2025-04-09",
          cnpj_lojista: "11.222.333/0001-44"
        }
      ]
    end

    context 'with valid payload' do
      it 'returns success HTTP status :ok' do
        post '/purchases/export_csv', params: { data: payload }

        expect(response).to have_http_status(:ok)
      end

      it 'returns csv content type' do
        post '/purchases/export_csv', params: { data: payload }

        expect(response.content_type).to include('text/csv')
      end

      it 'returns a cvs with correct fiels' do
        post '/purchases/export_csv', params: { data: payload }

        csv = CSV.parse(response.body, headers: true)

        expect(csv.headers).to contain_exactly(
          'identificacao_unica',
          'bandeira',
          'cnpj_lojista',
          'data_liquidacao',
          'valor_total'
        )
      end

      it 'returns the correct quantity of transactions' do
        post '/purchases/export_csv', params: { data: payload }

        csv = CSV.parse(response.body, headers: true)

        expect(csv.size).to eq(17)
      end
    end
  end
end
