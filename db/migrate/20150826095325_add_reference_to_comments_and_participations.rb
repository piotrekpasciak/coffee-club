class AddReferenceToCommentsAndParticipations < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.remove :user_id
      t.remove :event_id

      t.references :user, index: true
      t.references :event, index: true
    end

    change_table :participations do |t|
      t.remove :user_id
      t.remove :event_id

      t.references :user, index: true
      t.references :event, index: true
    end
  end
end
