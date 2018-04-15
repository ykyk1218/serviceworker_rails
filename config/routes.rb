Rails.application.routes.draw do
  root 'welcome#index'
  get '/welcome' => 'welcome#index'
end
