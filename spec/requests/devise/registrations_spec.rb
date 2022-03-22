require 'swagger_helper'

RSpec.describe 'devise/registrations', type: :request do
  include Mocks

  before :all do
    generate_user
    authenticate(@user)
  end

  after :all do
    @user.destroy
  end

  path '/api/signup' do
    post('Register a new user') do
      tags 'Registrations'
      consumes 'application/json'
      parameter name: :registration, in: :body, schema: { '$ref' => '#components/schemas/registration' }

      response(200, 'successful') do
        let(:registration) do
          { user: { name: 'Ruben', email: 'rpire@email.com', password: '12345678' } }
        end
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => { example: JSON.parse(response.body, symbolize_names: true) }
          }
        end
        run_test!
      end
    end
  end
end
