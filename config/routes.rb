Rails.application.routes.draw do

  root 'common#su'

  get 'xiuxian', to: 'common#xiuxian'
  get 'books', to: 'books#index'

  get 'room',to: 'chat_rooms#room'
  match '/auth', to: 'chat_rooms#auth', :via => [:get, :post]

  get 'books/comments', to: 'books#comments'






  resources :comments
  # this is for test development environment action cable
  # mount ActionCable.server => '/cable'

  get 'books/category/:id', to: 'books#category'

  get 'books/test', to: 'books#test'
  get 'books/download/:id', to: 'books#download'

  # get 'books/previous/:curr_pre/:pre_pos/:id',to: 'books#previous'
  get 'books/next/:next_pos/:id',to: 'books#next'


  resources :books


  resources :authors
  resources :categories
  # match '/auth', to: 'common#auth', :via => [:get, :post]


  # get 'index', to: 'common#index'



  # get '/doc',to: 'chat_rooms#index'

  # get '/su',to: 'chat_rooms#index'

  get '/canvas', to: 'chat_rooms#canvas'

  get '/chat_rooms/join', to: 'chat_rooms#join'
  get '/chat_rooms/leave', to: 'chat_rooms#leave'

  # resources :chat_rooms
  # resources :messages
  # resources :users

  #  Boolean to anchor a <tt>match</tt> pattern. Default is true. When set to
  #  false, the pattern matches any request prefixed with the given path.
  # match '/', to: 'chat_rooms#su', anchor: false, via: :get


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
