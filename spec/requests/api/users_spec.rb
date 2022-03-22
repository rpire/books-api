require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  include Mocks

  before :all do
    generate_admin
    generate_user
    authenticate(@admin)

    @example = {
      user: {
        name: 'Average Anoying Admin',
        bio: 'I come to destroy your user\'s dreams.',
        icon: 0,
        email: 'adminuser@email.com',
        password: '1234567'
      }
    }
  end

  after :all do
    @admin.destroy
    @user.destroy
  end

  path '/api/users' do
    get('List all users (reseved for admin accounts)') do
      tags 'Users'
      security [bearer_auth: []]
      produces 'application/json'

      response(200, 'successful') do
        let(:Authorization) { @token }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => { example: JSON.parse(response.body, symbolize_names: true) }
          }
        end
        run_test!
      end
    end
  end

  # rubocop:disable Metrics

  path '/api/users/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'User\'s ID'

    get('Display information of the user with the provided ID') do
      tags 'Users'
      security [bearer_auth: []]
      produces 'application/json'
      response(200, 'successful') do
        let(:id) { @admin.id }
        let(:Authorization) { @token }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => { example: JSON.parse(response.body, symbolize_names: true) }
          }
        end
        run_test!
      end
    end

    put('Edit the information of the user with the provided ID') do
      tags 'Users'
      security [bearer_auth: []]
      consumes 'application/json'
      produces 'application/json', 'application/xml'
      parameter name: :user, in: :body, schema: { '$ref' => '#/components/schemas/user' }
      response(202, 'successful') do
        let(:id) { @admin.id }
        let(:Authorization) { @token }
        let(:user) { @example }

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

    # rubocop:enable Metrics

    delete('Delete the user with the provided ID') do
      tags 'Users'
      security [bearer_auth: []]
      response(204, 'successful') do
        let(:id) { @user.id }
        let(:Authorization) { @token }

        run_test!
      end
    end
  end
end
