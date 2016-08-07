class ChangeNewsletterColumn < ActiveRecord::Migration
  def up
    change_column :users, :newsletter, :boolean, default: false, null: false
  end

  def down
    change_column :users, :newsletter, :boolean, default: true, null: false
  end
end
