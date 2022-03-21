require 'swagger_helper'

RSpec.describe 'devise/sessions', type: :request do
  include Mocks

  before :all do
    generate_user
  end

  after :all do
    @user.destroy
  end

  path '/api/login' do
    post('Log into a new session') do
      tags 'Sessions'
      consumes 'application/json'
      parameter name: :session, in: :body, schema: { '$ref' => '#components/schemas/session' }

      response(200, 'successful') do
        header 'Authorization', type: :string, description: 'Bearer token in JWT format'
        let(:session) do
          { user: { email: 'hp_fan@email.com', password: 'expeliarmus' } }
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
