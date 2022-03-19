require 'rails_helper'

# rubocop:disable Metrics

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: { title: 'API V1', version: 'v1' },
      components: {
        schemas: {
          registration: {
            type: :object,
            properties: {
              user: {
                name: :string,
                email: :string,
                password: :string
              }
            },
            required: %w[name email password]
          },
          session: {
            type: :object,
            properties: {
              user: {
                email: :string,
                password: :string
              }
            },
            required: %w[email password]
          },
          book: {
            type: :object,
            properties: {
              book: {
                title: :string,
                author: :string,
                category: :string,
                current_chapter: :string,
                num_of_pages: :integer,
                current_page: :integer
              }
            },
            required: %w[title author category current_chapter num_of_pages current_page]
          }
        },
        securitySchemes: {
          bearer_auth: { type: :http, scheme: :bearer, bearerFormat: JWT }
        }
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: { default: 'www.example.com' }
          }
        }
      ]
    }
  }
  config.swagger_format = :yaml
end

# rubocop:enable Metrics
