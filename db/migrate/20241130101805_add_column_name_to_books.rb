class AddColumnNameToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :book_cover, :string
  end
end
