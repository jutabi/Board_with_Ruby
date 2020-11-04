Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/' => 'home#index'


  get 'member/register' => 'member#register'
  post 'member/register_process' => 'member#register_process'

  get '/member/login' => 'member#login'
  post 'member/login_process' => 'member#login_process'

  get 'member/logout' => 'member#logout'

  get 'member/modify' => 'member#modify'
  post 'member/modify_process' => 'member#modify_process'

  get 'member/withdrawal' => 'member#withdrawal'
  post 'member/withdrawal_process' => 'member#withdrawal_process'


  get 'post/write' => 'post#write'
  post '/post/create' => 'post#create'

  get '/post/view/:post_id' => 'post#view'

  get 'post/modify/:post_id' => 'post#modify'
  post '/post/update/:post_id' => 'post#update'

  get 'post/delete/:post_id' => 'post#delete'
end
