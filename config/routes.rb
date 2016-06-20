Rails.application.routes.draw do

  root 'articles#home'

  get '/articles/about_me', to: 'articles#about_me', as: 'about_me'

  resources :articles, except: [:show, :destroy]
  get '/articles/:id/delete', to: 'articles#delete', as: "delete_article"


  get '/blogs/_index', to: 'blogs#_index', as: 'blog_index_partial'
  get '/blogs/:blog_id/comments/_new', to: 'comments#_new', as: 'comments_form_partial'
  resources :blogs, only: [:index, :show] do
    resources :comments, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :code_example, only: [:show]
  end
  get '/comments/_comment', to: 'comments#_comment', as: 'comments_partial'



  resources :users, except: [:destroy]
  resources :session, only: [:create, :new]

  get '/session/delete', to: 'session#delete', as: 'logout'

  resources :projects, only: [:index, :show]

  get '/partials/_new_comment_link', to: 'partials#_new_comment_link', as:"new_comment_link"
  get '/partials/_blog_show', to: 'partials#_blog_show', as: 'blog_show_partial'

end
