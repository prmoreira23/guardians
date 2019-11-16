Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'webhook', to: 'application#verify_webhook'
  post 'webhook', to: 'notification#message_received'
  post 'users', to: 'user#create'
end
