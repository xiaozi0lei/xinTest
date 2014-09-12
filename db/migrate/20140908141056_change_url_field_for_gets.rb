class ChangeUrlFieldForGets < ActiveRecord::Migration
  def change
		change_column :gets, :url, :text
  end
end
