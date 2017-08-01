Rails.application.routes.draw do
  scope 'worksheet_registry' do
    resources :worksheets, only: [:index, :show, :update]
    resources :attachments, only: :create
    resources :users, only: :create do
      collection do
        post :sign_in, to: 'users#sign_in'
      end
    end
  end

  scope 'file_server/api', defaults: { format: :json } do
    namespace :v1 do
      resources :images, only: [:show, :create]
    end
  end

end
