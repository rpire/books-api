require 'swagger_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'api/books', type: :request do
  before :all do
    @user = User.create(
      name: 'Average HP Fan',
      bio: 'I love fantasy books!',
      icon: 7,
      email: 'hp_fan@email.com',
      password: 'expeliarmus'
    )

    @book_one = Book.create(
      user_id: @user.id,
      title: 'Harry Potter and the Philosopher\'s Stone',
      author: 'J.K. Rowling',
      category: 'Fantasy Novel',
      current_chapter: 'Diagon Alley',
      num_of_pages: 254,
      current_page: 77
    )

    @book_two = Book.create(
      user_id: @user.id,
      title: 'I Don\'t Wanna Go Mr. Stark',
      author: 'Peter R. Parker',
      category: 'Farewell',
      current_chapter: 'Avengers: Infinity War',
      num_of_pages: 44,
      current_page: 4
    )

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
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create book') do
      tags 'Books'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          book: {
            title: { type: :string },
            author: { type: :string },
            category: { type: :string },
            current_chapter: { type: :string },
            num_of_pages: { type: :integer },
            current_page: { type: :integer }
          }
        },
        required: %w[title author category current_chapter num_of_pages current_page]
      }

      response(201, 'successful') do
        let(:Authorization) { @auth }
        let(:book) do
          {
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
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          book: {
            title: { type: :string },
            author: { type: :string },
            category: { type: :string },
            current_chapter: { type: :string },
            num_of_pages: { type: :integer },
            current_page: { type: :integer }
          }
        },
        required: %w[title author category current_chapter num_of_pages current_page]
      }

      response(202, 'successful') do
        let(:Authorization) { @auth }
        let(:id) { @book_one.id }
        let(:book) do
          {
            book: {
              title: 'Harry Potter and the Philosopher\'s Stone',
              author: 'J.K. Rowling',
              category: 'Fantasy Novel',
              current_chapter: 'Diagon Alley',
              num_of_pages: 254,
              current_page: 77
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

    delete('delete book') do
      tags 'Books'
      security [bearer_auth: []]

      response(204, 'successful') do
        let(:Authorization) { @auth }
        let(:id) { @book_two.id }
        run_test!
      end
    end
  end
end
