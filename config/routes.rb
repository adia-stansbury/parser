Rails.application.routes.draw do
  root 'parsed_records#index'

  resources :parsed_records, only: [:index]
end
