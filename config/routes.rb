Rails.application.routes.draw do
  resources :purchase_invoice_lines
  resources :purchase_invoices do
    get :attachment, on: :member
  end
  resources :journal_entries
  resources :accounts
  resources :companies
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
