Rails.application.routes.draw do
  resources :documents, only: [:index, :new, :create, :show]
  resources :purchase_invoices, nav: { icon: 'document-text' } do
    resources :lines, module: 'purchase_invoices', only: [:create, :index]
    get :attachment, on: :member
  end

  resource :purchase_invoice, only: [] do
    resources :lines, only: [:show, :update, :destroy], module: 'purchase_invoices'
  end


  resources :ledger_entries, nav: { icon: 'book-open' }
  resources :accounts, nav: { icon: 'folder-open' } do
    get :search, on: :collection
  end
  resources :companies, nav: { icon: 'building-office-2' } do
    get :select, on: :member
  end

  resources :documents, only: [:index, :new, :create, :show], nav: { icon: 'archive-box' } do
    get :attachment, on: :member
  end

  get '/suppliers/search', to: 'suppliers#search'
  get '/currencies/search', to: 'currencies#search'

  # Defines the root path route ("/")
  root "companies#index"
end
