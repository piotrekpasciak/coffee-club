class AddTemporaryNewsletterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :temporary_newsletter, :boolean, default: false, null: false
    add_column :users, :temporary_newsletter_status, :boolean, default: false, null: false
  end
end
