Rails.application.routes.draw do

  root 'chat_rooms#su'

  match '/auth',to: 'chat_rooms#auth',:via => [:get,:post]

  get '/su',to: 'chat_rooms#su'
  get '/canvas',to: 'chat_rooms#canvas'

  get '/chat_rooms/join',to: 'chat_rooms#join'
  get '/chat_rooms/leave',to: 'chat_rooms#leave'

  resources :chat_rooms
  resources :messages
  resources :users

  #  Boolean to anchor a <tt>match</tt> pattern. Default is true. When set to
  #  false, the pattern matches any request prefixed with the given path.
  match '/',to: 'chat_rooms#index',anchor: false, via: :get


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
