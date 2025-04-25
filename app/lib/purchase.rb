class Purchase
  attr_reader :credit_card_brand, :store_owner_cnpj, :installments_details,
              :purchase_date, :total_value

  def initialize(credit_card_brand:, store_owner_cnpj:, purchase_date:, total_value:, installments_details: [])
    @credit_card_brand = credit_card_brand
    @store_owner_cnpj = store_owner_cnpj
    @purchase_date = purchase_date
    @total_value = total_value
    @installments_details = installments_details
  end

  def transactions
    @transactions ||= Transaction.build(
      installments: installments_details,
      base_data: base_transaction_data
    )
  end

  private

  def base_transaction_data
    {
      credit_card_brand: credit_card_brand,
      store_owner_cnpj: store_owner_cnpj,
      total_value: total_value,
      purchase_date: purchase_date
    }
  end
end
