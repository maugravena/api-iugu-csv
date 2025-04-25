require 'rails_helper'
require 'csv'

RSpec.describe TransactionsCsvExporter, type: :service do
  let(:purchase) do
    Purchase.new(
      credit_card_brand: 'VISA',
      store_owner_cnpj: '12.345.678/0001-01',
      total_value: 100,
      purchase_date: '2025-04-12',
      installments_details: [
        { settlement_date: Date.parse('2025-04-17') },
        { settlement_date: Date.parse('2025-05-17') }
      ]
    )
  end

  it 'exports transactions with headers and correct data' do
    csv_output = TransactionsCsvExporter.call([purchase])
    csv = CSV.parse(csv_output, headers: true)

    expect(csv.headers).to contain_exactly(
      'identificacao_unica',
      'bandeira',
      'cnpj_lojista',
      'data_liquidacao',
      'valor_total'
    )

    expect(csv.length).to eq(2)
    expect(csv[0]['bandeira']).to eq('VISA')
    expect(csv[0]['cnpj_lojista']).to eq('12.345.678/0001-01')
    expect(csv[0]['data_liquidacao']).to eq('2025-04-17')
    expect(csv[0]['valor_total']).to eq('100')
    expect(csv[1]['bandeira']).to eq('VISA')
    expect(csv[1]['cnpj_lojista']).to eq('12.345.678/0001-01')
    expect(csv[1]['data_liquidacao']).to eq('2025-05-17')
    expect(csv[1]['valor_total']).to eq('100')
  end
end
