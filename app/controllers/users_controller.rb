class UsersController < ApplicationController
    before_action :authorize_admin!, only: [:index] # Restringe o acesso ao método `index` para administradores

  def index
    @users = User.all # Recupera todos os usuários
  end

  private

  # Método para verificar se o usuário atual é um administrador
  def authorize_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: 'Você não tem permissão para acessar esta página.'
    end
  end
end
