class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :genre
      t.string :author
      t.integer :year
      t.string :book_id

      t.timestamps
    end
  end
end
