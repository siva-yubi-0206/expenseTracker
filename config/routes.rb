Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  #only: %[create index show]

  resources :employees
  put "delete_emp", to: "employees#delete_emp"
  get "show_employee", to: "employees#show_employee"
  put "terminate", to: "employees#terminate"

  resources :expense_group_requests
  post "create_expense_group", to:"expense_group_requests#create_expense_group"
  put "update_expense_group", to: "expense_group_requests#update_expense_group"
  put "delete_expense_group", to: "expense_group_requests#delete_expense_group"

  resources :expense_requests, only: %[index]
  post "create_expense", to: "expense_requests#create_expense"
  get "show_expenses", to: "expense_requests#show_expenses"
  put "delete_expenses", to: "expense_requests#delete_expenses"
  put "update_expense_status", to: "expense_requests#update_expense_status"

  resources :comments
  post "create_comment", to: "comments#create_comment"
  put "delete_comment", to: "comments#delete_comment" 
  put "edit_comment", to: "comments#edit_comment"

  resources :replies
  post "reply_comment", to: "replies#reply_comment"
  put "edit_reply", to: "replies#edit_reply"
  put "delete_reply", to: "replies#delete_reply"
      
end
