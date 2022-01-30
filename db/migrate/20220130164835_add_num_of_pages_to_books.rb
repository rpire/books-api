class AddNumOfPagesToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :num_of_pages, :integer
  end
end
