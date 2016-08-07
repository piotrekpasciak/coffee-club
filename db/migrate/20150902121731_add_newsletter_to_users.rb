class AddNewsletterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newsletter, :boolean, default: true, null: false
  end
end
