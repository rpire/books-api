class AddCurrentPageToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :current_page, :integer
  end
end
