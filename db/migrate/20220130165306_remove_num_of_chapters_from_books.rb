class RemoveNumOfChaptersFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :num_of_chapters, :integer
    change_column :books, :current_chapter, :string
  end
end
