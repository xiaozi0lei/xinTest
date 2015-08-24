class AddParameterToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :parameter, :string
  end
end
