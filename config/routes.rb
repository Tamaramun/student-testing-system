Rails.application.routes.draw do
  root 'tests#index'
  devise_for :users

  resources :tests,  :except => [:destroy] do
    resources :questions, :except => [:destroy] do
      resources :answers,  :except => [:destroy]
    end
  end

  delete 'tests/:id' => 'tests#destroy', as: 'tests_destroy'
  delete 'tests/:test_id/questions/:id' => 'questions#destroy', as: 'questions_destroy'
  delete 'tests/:test_id/questions/:question_id/answers/:id' => 'answers#destroy', as: 'answers_destroy'

  get 'registration_for_test/:id' => 'results#new', as: 'new_result'
  post 'test_registration/:id' => 'results#create', as: 'save_result'

  get 'test/:id' => 'results#pass_test', as: 'pass_test'
  post 'answers/:id' => 'results#save_answer', as: 'save_answer'

  get 'test_results/:id' => 'results#index', as: 'test_results'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
