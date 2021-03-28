Rails.application.routes.draw do

  root to: 'maps#index'
  get 'maps', to: 'maps#index'
  get 'detail', to:'maps#detail'
  
end
