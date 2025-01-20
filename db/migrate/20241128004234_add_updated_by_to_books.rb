class AddUpdatedByToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :updated_by, :string
  end
end
