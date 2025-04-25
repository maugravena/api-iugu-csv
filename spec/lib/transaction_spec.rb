require 'rails_helper'

RSpec.describe Transaction do
  let(:base_data) do
    {
      credit_card_brand: 'VISA',
      store_owner_cnpj: '12.345.678/0001-99',
      total_value: 100.0,
      purchase_date: '2025-04-20'
    }
  end

  describe '.build' do
    context 'when installments are blank' do
      it 'returns a single transaction with correct settlement date' do
        transactions = Transaction.build(installments: [], base_data: base_data)

        expect(transactions.length).to eq(1)
        transaction = transactions.first

        expect(transaction.credit_card_brand).to eq('VISA')
        expect(transaction.store_owner_cnpj).to eq('12.345.678/0001-99')
        expect(transaction.total_value).to eq(100.0)
        expect(transaction.settlement_date).to eq('2025-05-20')
        expect(transaction.unique_identification).to be_present
      end
    end

    context 'when installments are present' do
      let(:installments) do
        [
          { settlement_date: '2025-05-10' },
          { settlement_date: '2025-06-10' }
        ]
      end

      it 'returns multiple transactions with correct settlement dates' do
        transactions = Transaction.build(installments: installments, base_data: base_data)

        expect(transactions.length).to eq(2)

        expect(transactions[0].settlement_date).to eq('2025-05-10')
        expect(transactions[1].settlement_date).to eq('2025-06-10')

        transactions.each do |transaction|
          expect(transaction.credit_card_brand).to eq('VISA')
          expect(transaction.store_owner_cnpj).to eq('12.345.678/0001-99')
          expect(transaction.total_value).to eq(100.0)
          expect(transaction.unique_identification).to be_present
        end
      end
    end
  end
end
