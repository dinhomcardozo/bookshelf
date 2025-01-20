class User < ApplicationRecord
  before_save :set_default_admin, if: :new_record?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  # Define false como valor padrão para admin se for um novo registro
  def set_default_admin
    self.admin ||= false
  end
end