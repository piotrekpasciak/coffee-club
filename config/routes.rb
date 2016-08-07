Rails.application.routes.draw do
  resources :events, except: [:edit, :new] do
    post :confirm, :complete, :expire, :extend
    delete :leave

    resources :participations, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  devise_for :users

  get 'my-events', to: 'page#my_events'
  get 'ranking', to: 'page#ranking'

  get 'coffee-counters', to: 'page#coffee_counters'
  get 'current-user', to: 'users#show_current_user'

  get 'user-achievements', to: 'user_achievements#user_achievements'
  get 'show-user-achievements', to: 'user_achievements#show_user_achievements'

  post 'update-subscription', to: 'users#update_subscription'
  get 'update-temporary-subscription', to: 'users#update_temporary_subscription'

  post 'update-user-achievements', to: 'user_achievements#update_all'

  root 'page#home'
end
