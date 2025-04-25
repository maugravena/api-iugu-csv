class Transaction
  DAYS_FOR_SETTLEMENT = 30.days

  attr_reader :credit_card_brand, :store_owner_cnpj, :total_value, :settlement_date, :unique_identification

  # MELHORIA: Utilizar uma solução que pode ser mais performática para identificador único no lugar de UUID
  def initialize(
    credit_card_brand:,
    store_owner_cnpj:,
    total_value:,
    settlement_date:,
    unique_identification: SecureRandom.uuid
  )
    @credit_card_brand = credit_card_brand
    @store_owner_cnpj = store_owner_cnpj
    @total_value = total_value
    @settlement_date = settlement_date
    @unique_identification = unique_identification
  end

  # MELHORIA: Extrair as regras de negócio para uma classe builder
  def self.build(installments:, base_data:)
    return [build_single(base_data)] if installments.blank?

    build_multiple(installments, base_data)
  end

  private

  def self.build_single(base_data)
    new(
      credit_card_brand: base_data[:credit_card_brand],
      store_owner_cnpj: base_data[:store_owner_cnpj],
      total_value: base_data[:total_value],
      settlement_date: settlement_date(base_data[:purchase_date])
    )
  end

  def self.build_multiple(installments, base_data)
    installments.map do |installment|
      new(
        credit_card_brand: base_data[:credit_card_brand],
        store_owner_cnpj: base_data[:store_owner_cnpj],
        total_value: base_data[:total_value],
        settlement_date: installment[:settlement_date]
      )
    end
  end

def self.settlement_date(purchase_date) = (purchase_date.to_date + DAYS_FOR_SETTLEMENT).to_s
end
