class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :num_of_chapters
      t.integer :current_chapter

      t.timestamps
    end
  end
end
