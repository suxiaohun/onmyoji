Rails.application.routes.draw do

  root 'common#index'

  get 'push',to: 'test#push'
  match 'push_target',to: 'test#push_target', :via => [:get, :post]
  match 'call_event_push',to: 'test#call_event_push', :via => [:get, :post]

  get 'mobile_area', to: 'tools#mobile_area'
  get 'get_mobile_area', to: 'tools#get_mobile_area'
  post 'comment_save', to: 'tools#comment_save'

  match 'oss_check_file_callback', to: 'common#oss_check_file_callback', :via => [:get, :post]
  match 'paas_callback/:app_id/:timestamp/:sign', to: 'common#paas_callback', :via => [:get, :post]
  match 'mxl', to: 'common#mxl', :via => [:get, :post]
  match 'md5', to: 'common#md5', :via => [:get, :post]
  match 'sha1', to: 'common#sha1', :via => [:get, :post]
  match 'generate_md5', to: 'common#generate_md5', :via => [:get, :post]
  match 'generate_sha1', to: 'common#generate_sha1', :via => [:get, :post]
  match 'test2', to: 'chat_rooms#test2', :via => [:get, :post]
  match 'test', to: 'chat_rooms#test', :via => [:get, :post]
  match 'json_format', to: 'common#json_format', :via => [:get]
  match 'unicode', to: 'common#unicode', :via => [:get]

  get 'blank', to: 'common#blank'
  get 'app_version', to: 'yys#app_version'
  get 'websocket_connections', to: 'yys#connections'

  delete 'clean_cookie/:sama', to: "yys#clean_cookie"
  resources :pieces

  get 'yys', to: 'yys#index'

  get 'mitama', to: 'yys#mitama'
  post 'yys/cards', to: 'yys#cards'
  get 'yys/rate', to: 'yys#rate'

  match 'yys/auth', to: 'yys#auth', :via => [:get, :post]

  post 'yys/summon', to: 'yys#summon'

  get 'all_cookies', to: 'yys#all_cookies'
  get 'all_pieces', to: 'yys#all_pieces'
  get 'yys/add_need_pieces', to: 'yys#add_need_pieces'
  get 'yys/add_own_pieces', to: 'yys#add_own_pieces'

  post 'yys/match', to: 'yys#match'
  post 'yys/pieces', to: 'yys#pieces'
  get 'my_pieces', to: 'yys#my_pieces'


  get 'skills', to: 'common#skills'
  get 'items', to: 'common#items'
  get 'groups', to: 'common#groups'
  get 'colors', to: 'common#colors'
  get 'xiuxian', to: 'common#xiuxian'
  get 'su', to: 'common#su'
  get 'books', to: 'books#index'

  get 'rooms', to: 'chat_rooms#rooms'
  match '/auth', to: 'chat_rooms#auth', :via => [:get, :post]
  match 'common/auth', to: 'common#auth', :via => [:get, :post]

  get 'books/comments', to: 'books#comments'


  resources :comments
  # this is for test development environment action cable
  # mount ActionCable.server => '/cable'

  get 'books/category/:id', to: 'books#category'

  match 'books/test', to: 'books#test', :via => [:get, :post]
  get 'books/download/:id', to: 'books#download'

  get 'books/previous/:curr_pre/:pre_pos/:id', to: 'books#previous'
  get 'books/next/:next_pos/:id', to: 'books#next'
  get 'books/goto', to: 'books#goto'
  get 'books/page_size', to: 'books#page_size'


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
