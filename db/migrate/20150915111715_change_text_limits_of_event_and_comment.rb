class ChangeTextLimitsOfEventAndComment < ActiveRecord::Migration
  def up
    change_column :events, :description, :string, limit: 160
    change_column :comments, :text, :text, limit: 400
  end

  def down
    change_column :events, :description, :string, limit: nil
    change_column :comments, :text, :text, limit: nil
  end
end
