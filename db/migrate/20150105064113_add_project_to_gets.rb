class AddProjectToGets < ActiveRecord::Migration
  def change
    add_column :gets, :project, :string
  end
end
