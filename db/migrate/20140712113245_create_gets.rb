class CreateGets < ActiveRecord::Migration
  def change
    create_table :gets do |t|
      t.string :url
      t.string :result

      t.timestamps
    end
  end
end
