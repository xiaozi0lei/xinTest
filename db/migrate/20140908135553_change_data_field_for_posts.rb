class ChangeDataFieldForPosts < ActiveRecord::Migration
  def change
		change_column :posts, :data, :text
  end
end
