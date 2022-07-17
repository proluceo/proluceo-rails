Rails.application.routes.draw do

  resources :purchase_invoices, nav: { icon: 'document-text' } do
    resources :lines, module: 'purchase_invoices', only: [:create, :index]
    get :attachment, on: :member
  end

  resource :purchase_invoice, only: [] do
    resources :lines, only: [:show, :update, :destroy], module: 'purchase_invoices'
  end


  resources :journal_entries, nav: { icon: 'book-open' }
  resources :accounts, nav: { icon: 'folder-open' }
  resources :companies, nav: { icon: 'library' } do
    get :select, on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "companies#index"
end
