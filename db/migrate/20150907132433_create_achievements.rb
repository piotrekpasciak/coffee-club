class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :name
      t.text :text
      t.string :image

      t.timestamps null: false
    end
  end
end
