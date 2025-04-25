class TransactionsCsvExporter
  HEADERS = {
    identificacao_unica: :unique_identification,
    bandeira: :credit_card_brand,
    cnpj_lojista: :store_owner_cnpj,
    data_liquidacao: :settlement_date,
    valor_total: :total_value
  }.freeze

  def self.call(purchases)
    CSV.generate(headers: true) do |csv|
      csv << HEADERS.keys.map(&:to_s)

      purchases.flat_map(&:transactions).each do |transaction|
        csv << HEADERS.values.map { |attr| transaction.public_send(attr) }
      end
    end
  end
end
