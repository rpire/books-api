require 'rails_helper'

# rubocop:disable Metrics

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: { title: 'BOOKS API', version: 'V1' },
      components: {
        schemas: {
          registration: {
            type: :object,
            properties: {
              user: {
                type: :object,
                properties: {
                  name: { type: :string },
                  email: { type: :string },
                  password: { type: :string }
                },
                required: %w[name email password]
              }
            },
            required: %i[user]
          },
          session: {
            type: :object,
            properties: {
              user: {
                type: :object,
                properties: {
                  email: { type: :string },
                  password: { type: :string }
                },
                required: %w[email password]
              }
            },
            required: %i[user]
          },
          user: {
            type: :object,
            properties: {
              user: {
                type: :object,
                properties: {
                  name: { type: :string },
                  bio: { type: :string },
                  icon: { type: :integer },
                  password: { type: :string }
                }
              }
            },
            required: %i[user]
          },
          book: {
            type: :object,
            properties: {
              book: {
                type: :object,
                properties: {
                  title: { type: :string },
                  author: { type: :string },
                  category: { type: :string },
                  current_chapter: { type: :string },
                  num_of_pages: { type: :integer },
                  current_page: { type: :integer }
                },
                required: %w[
                  title author category current_chapter num_of_pages current_page
                ]
              }
            },
            required: %i[book]
          }
        },
        securitySchemes: {
          bearer_auth: { type: :http, scheme: :bearer, bearerFormat: JWT }
        }
      },
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: { default: 'localhost:3000' }
          }
        }
      ]
    }
  }
  config.swagger_format = :yaml
end

# rubocop:enable Metrics
