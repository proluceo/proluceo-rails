Rails.application.routes.draw do
  # Accounting
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

  # Sales
  resources :market_members, nav: { icon: 'funnel' }

  # Common
  resources :documents, only: [:index, :new, :create, :show], nav: { icon: 'archive-box' } do
    get :attachment, on: :member
  end

  resources :suppliers, only: [:index, :new, :create] do
    get :search, on: :collection
  end

  get '/currencies/search', to: 'currencies#search'

  # Omniauth
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'

  # Defines the root path route ("/")
  root "companies#index"
end
