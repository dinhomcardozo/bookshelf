
#As rotas conectam URLs específicas a controladores e ações correspondentes.

Rails.application.routes.draw do #usado para configurar todas as rotas da aplicação.
  devise_for :users #adiciona todas as rotas necessárias para gerenciar usuários utilizando a gem Devise. / Inclui rotas para registro, login, logout, recuperação de senha, edição de conta e mais.

#Tipos de rotas exemplos:
# /users/sign_in → Página de login.
# /users/sign_up → Página de registro.
# /users/sign_out → Rota para logout.
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get "up" => "rails/health#show", as: :rails_health_check
  
  resources :books do
    collection do
      get :bulk_upload # Página para o formulário de upload
      post :import     # Endpoint para processar o arquivo
    end
  end
  

  #As rotas geradas incluem:
# GET /books → index (listar livros).
# GET /books/new → new (formulário para criar um livro).
# POST /books → create (salvar um novo livro).
# GET /books/:id → show (exibir detalhes de um livro específico).
# GET /books/:id/edit → edit (formulário para editar um livro).
# PATCH /books/:id → update (atualizar um livro).
# DELETE /books/:id → destroy (excluir um livro).


  root "books#index" # Define a página inicial da aplicação / ação index é mapeada

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
