Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'api/login',
      sign_out: 'api/logout',
      registration: 'api/signup'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }

  namespace :api, defaults: { format: :json } do
    resources :users do
    end
    resources :books
  end
end
