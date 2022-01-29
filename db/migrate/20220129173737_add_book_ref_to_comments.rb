class AddBookRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :book, null: false, foreign_key: true
  end
end
