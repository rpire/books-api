class AddIconToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :icon, :integer, default: 0
  end
end
