# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  event_id   :integer
#

RSpec.describe Participation, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:participation)).to be_valid
  end
end
