require 'swagger_helper'

RSpec.describe 'api/books', type: :request do
  include Mocks

  before :all do
    generate_user
    generate_books
    authenticate(@user)

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
  end

  after :all do
    @user.destroy
    @book_one.destroy
  end

  path '/api/books' do
    get('List the current user\'s books') do
      tags 'Books'
      security [bearer_auth: []]
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

    post('Create a new book') do
      tags 'Books'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :book, in: :body, schema: { '$ref' => '#/components/schemas/book' }

      response(201, 'successful') do
        let(:Authorization) { @token }
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

    get('Display information of the book with the provided ID') do
      tags 'Books'
      produces 'application/json', 'application/xml'
      security [bearer_auth: []]
      response(200, 'successful') do
        let(:Authorization) { @token }
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

    put('Edit information of the book with the provided ID') do
      tags 'Books'
      security [bearer_auth: []]
      consumes 'application/json'
      produces 'application/json', 'application/xml'
      parameter name: :book, in: :body, schema: { '$ref' => '#/components/schemas/book' }

      response(202, 'successful') do
        let(:Authorization) { @token }
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

    delete('Delete the book with the provided ID') do
      tags 'Books'
      security [bearer_auth: []]

      response(204, 'successful') do
        let(:Authorization) { @token }
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
