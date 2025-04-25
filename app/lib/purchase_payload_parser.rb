class PurchasePayloadParser
  def self.parse(payload)
    payload = JSON.parse(payload)

    payload.map do |purchase_data|
      purchase_data = purchase_data.deep_symbolize_keys

      Purchase.new(
        credit_card_brand: purchase_data[:bandeira],
        store_owner_cnpj: purchase_data[:cnpj_lojista],
        total_value: purchase_data[:valor_total],
        purchase_date: purchase_data[:data_compra],
        installments_details: build_installments(purchase_data.fetch(:parcelas_detalhadas, nil))
      )
    end
  end

  def self.build_installments(parcelas)
    return [] if parcelas.nil?

    parcelas.map do |parcela|
      { settlement_date: parcela[:data_liquidacao] }
    end
  end
end
