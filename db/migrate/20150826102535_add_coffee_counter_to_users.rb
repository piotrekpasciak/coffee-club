class AddCoffeeCounterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coffee_counter, :integer, default: 0, null: false
  end
end
