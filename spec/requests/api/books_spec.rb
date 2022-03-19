require 'swagger_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'api/books', type: :request do
  include Mocks

  before :all do
    generate_user
    generate_books

    @example = {
      book: {
        title: 'Harry Potter and the Philosopher\'s Stone',
        author: 'J.K. Rowling',
        category: 'Fantasy Novel',
        current_chapter: 'Diagon Alley',
        num_of_pages: 254,
        current_page: 88
      }
    }

    @auth = Devise::JWT::TestHelpers.auth_headers({}, @user).values.first
  end

  after :all do
    @user.destroy
    @book_one.destroy
  end

  path '/api/books' do
    get('list books') do
      tags 'Books'
      security [bearer_auth: []]
      response(200, 'successful') do
        let(:Authorization) { @auth }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => { example: JSON.parse(response.body, symbolize_names: true) }
          }
        end
        run_test!
      end
    end

    post('create book') do
      tags 'Books'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :book, in: :body, schema: { '$ref' => '#/components/schemas/book' }

      response(201, 'successful') do
        let(:Authorization) { @auth }
        let(:book) { @example }
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

  path '/api/books/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'Book\'s ID'

    get('show book') do
      tags 'Books'
      produces 'application/json', 'application/xml'
      security [bearer_auth: []]
      response(200, 'successful') do
        let(:Authorization) { @auth }
        let(:id) { @book_one.id }
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

    put('update book') do
      tags 'Books'
      security [bearer_auth: []]
      consumes 'application/json'
      produces 'application/json', 'application/xml'
      parameter name: :book, in: :body, schema: { '$ref' => '#/components/schemas/book' }

      response(202, 'successful') do
        let(:Authorization) { @auth }
        let(:id) { @book_one.id }
        let(:book) { @example }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => { example: JSON.parse(response.body, symbolize_names: true) }
          }
        end
        run_test!
      end
    end

    delete('delete book') do
      tags 'Books'
      security [bearer_auth: []]

      response(204, 'successful') do
        let(:Authorization) { @auth }
        let(:id) { @book_two.id }
        run_test!
      end

      response(401, 'unathorized') do
        let(:Authorization) { '' }
        let(:id) { @book_two.id }
        run_test!
      end
    end
  end
end

# rubocop:enable Metrics
