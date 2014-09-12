class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :project
      t.string :url
      t.string :data
      t.string :result

      t.timestamps
    end
  end
end
