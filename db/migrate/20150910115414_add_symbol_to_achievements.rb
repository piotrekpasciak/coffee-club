class AddSymbolToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :symbol, :string, null: false
  end
end
