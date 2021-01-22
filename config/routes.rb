Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "edit_user", to: "users/registrations#user_edit", as: :edit_user
  end

  resources :questions, only: [:new, :create, :show] do
    collection do
      get 'confirm'
      get 'question_all'
      get 'search'
      get 'category_search'
    end
    resources :comments, only: [:create, :edit] do
      member do
        get 'like'
      end
      collection do
        get 'find_like'
      end
    end
  end

  resources :users, only: [:show]
end
