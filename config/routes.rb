Rails.application.routes.draw do
  resources :purchase_invoice_lines
  resources :purchase_invoices, nav: true do
    get :attachment, on: :member
  end
  resources :journal_entries, nav: true
  resources :accounts, nav: true
  resources :companies, nav: true
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "companies#index"
end
