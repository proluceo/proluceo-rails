Rails.application.routes.draw do
  resources :purchase_invoice_lines, nav: { icon: 'document-text' }
  resources :purchase_invoices, nav: { icon: 'document' } do
    get :attachment, on: :member
  end
  resources :journal_entries, nav: { icon: 'book-open' }
  resources :accounts, nav: { icon: 'folder-open' }
  resources :companies, nav: { icon: 'library' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
