require 'rails_helper'

RSpec.describe '/purchases', type: :request do
  describe 'POST /purchases' do
    context 'with valid payload' do
      it 'returns success HTTP status :ok' do
        post '/purchases/export_csv'

        expect(response).to have_http_status(:ok)
      end

      it 'returns csv content type' do
        post '/purchases/export_csv'

        expect(response.content_type).to eq('text/csv')
      end
    end
  end
end
