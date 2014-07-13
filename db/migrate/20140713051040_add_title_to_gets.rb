class AddTitleToGets < ActiveRecord::Migration
  def change
    add_column :gets, :title, :string
  end
end
