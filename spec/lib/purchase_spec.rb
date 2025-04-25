require 'rails_helper'

RSpec.describe Purchase do
  let(:base_attrs) do
    {
      credit_card_brand: 'VISA',
      store_owner_cnpj: '12.345.678/0001-99',
      purchase_date: '2025-04-12',
      total_value: 1000.0
    }
  end

  describe 'initialization' do
    it 'sets all attributes correctly' do
      purchase = Purchase.new(**base_attrs)

      expect(purchase.credit_card_brand).to eq('VISA')
      expect(purchase.store_owner_cnpj).to eq('12.345.678/0001-99')
      expect(purchase.purchase_date).to eq('2025-04-12')
      expect(purchase.total_value).to eq(1000.0)
      expect(purchase.installments_details).to eq([])
    end

    context 'when installment_details is provided' do
      it 'sets the installment_details' do
        installments = [
          { installment: 1, value: 500.0, settlement_date: '2025-04-17' },
          { installment: 2, value: 500.0, settlement_date: '2025-05-17' }
        ]
        purchase = Purchase.new(**base_attrs.merge(installments_details: installments))

        expect(purchase.installments_details).to eq(installments)
      end
    end
  end

  describe '#transaction' do
    context 'when there are no installments' do
      it 'returns one transaction with correct settlement date' do
        purchase = Purchase.new(**base_attrs)

        transactions = purchase.transactions

        expect(transactions.size).to eq(1)
        transaction = transactions.first

        expect(transaction.settlement_date).to eq((purchase.purchase_date.to_date + 30.days).to_s)
        expect(transaction.store_owner_cnpj).to eq('12.345.678/0001-99')
        expect(transaction.credit_card_brand).to eq('VISA')
        expect(transaction.total_value).to eq(1000.0)
        expect(transaction.unique_identification).to be_present
      end
    end

    context 'when there are multiple installments' do
      let(:installments) do
        [
          { installment: 1, value: 500.0, settlement_date: '2025-04-17' },
          { installment: 2, value: 500.0, settlement_date: '2025-05-17' }
        ]
      end

      it 'returns one transaction per installment with correct settlement dates' do
        purchase = Purchase.new(**base_attrs, installments_details: installments)

        transactions = purchase.transactions

        expect(transactions.size).to eq(2)
        expect(transactions.map(&:settlement_date)).to eq(['2025-04-17', '2025-05-17'])
        expect(transactions.all? { |t| t.unique_identification.present? }).to be true
      end
    end
  end
end
