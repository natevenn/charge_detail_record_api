Rails.application.routes.draw do
  post 'rates', action: :rate, controller: 'rates'
end
