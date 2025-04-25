class PurchasesController < ApplicationController
  require 'csv'

  # MELHORIAS:
  # - adicionar tratamento de execeções
  # - fluxo assíncrono para grande volume de dados
  def export_csv
    data = permitted_params[:data]
    purchases = PurchasePayloadParser.parse(data.to_json)
    csv_data = TransactionsCsvExporter.call(purchases)

     render plain: csv_data, content_type: 'text/csv', status: :ok
  end

  private

  def permitted_params = params.permit(
    data: [
      :id,
      :bandeira,
      :valor_total,
      :qtd_parcelas,
      :data_compra,
      :cnpj_lojista,
      parcelas_detalhadas: [:parcela, :valor, :data_liquidacao]
    ]
  )
end
