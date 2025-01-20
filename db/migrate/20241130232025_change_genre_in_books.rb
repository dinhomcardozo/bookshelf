class ChangeGenreInBooks < ActiveRecord::Migration[8.0]
  def change
    change_column :books, :genre, :text
  end
end
