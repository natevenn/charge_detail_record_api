Rails.application.routes.draw do
  post 'rate', action: :rate, controller: 'rates'
end
