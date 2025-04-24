class PurchasesController < ApplicationController
  def export_csv
    send_data '', type: 'text/csv', status: :ok
  end
end
