class AddSubGenreToBook < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :sub_genre, :string
  end
end
