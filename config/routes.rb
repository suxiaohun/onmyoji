Rails.application.routes.draw do


  match '/auth', to: 'common#auth', :via => [:get, :post]

  get 'xiuxian', to: 'common#xiuxian'

  root 'chat_rooms#su'


  # get '/doc',to: 'chat_rooms#index'
  #
  # get '/su',to: 'chat_rooms#su'

  get '/canvas', to: 'chat_rooms#canvas'

  get '/chat_rooms/join', to: 'chat_rooms#join'
  get '/chat_rooms/leave', to: 'chat_rooms#leave'

  # resources :chat_rooms
  # resources :messages
  # resources :users

  #  Boolean to anchor a <tt>match</tt> pattern. Default is true. When set to
  #  false, the pattern matches any request prefixed with the given path.
  match '/', to: 'chat_rooms#su', anchor: false, via: :get


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
