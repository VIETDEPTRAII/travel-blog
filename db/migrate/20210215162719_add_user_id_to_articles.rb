class AddUserIdToArticles < ActiveRecord::Migration[6.1]
  def up
    add_column :articles, :user_id, :integer, null: false, foreign_keys: true
  end

  def down
    remove_column :articles, :user_id
  end
end
