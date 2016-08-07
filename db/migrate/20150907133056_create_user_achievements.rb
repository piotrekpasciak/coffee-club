class CreateUserAchievements < ActiveRecord::Migration
  def change
    create_table :user_achievements do |t|
      t.boolean :shown, default: false
      t.references :user, index: true, foreign_key: true, null: false
      t.references :achievement, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
