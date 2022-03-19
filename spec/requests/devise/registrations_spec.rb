require 'swagger_helper'

RSpec.describe 'devise/registrations', type: :request do
  path '/api/signup' do
    post('register user') do
      tags 'User Registration'
      consumes 'application/json'
      parameter name: :registration, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            name: :string,
            email: :string,
            password: :string
          }
        },
        required: %i[name email password]
      }
      response(200, 'successful') do
        let(:registration) do
          {
            user: {
              name: 'Ruben',
              email: 'rpire@email.com',
              password: '12345678'
            }
          }
        end
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
