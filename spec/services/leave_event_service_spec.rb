describe LeaveEventService do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }
  let(:closed_event) { FactoryGirl.create(:event, status: :closed) }
  let(:event_with_owner) { FactoryGirl.create(:event, owner: user) }

  it "is successful" do
    FactoryGirl.create(:participation, user: user, event: event)
    service = described_class.new(event, user)

    event = service.call
    expect(event.participations.count).to eq 0
  end

  it "raises NotMember Error" do
    service = described_class.new(event, user)

    expect { service.call }.to raise_exception LeaveEventService::Error, "You are not a member of this event!"
  end

  it "raises OwnerCantLeave Error" do
    service = described_class.new(event_with_owner, user)

    expect { service.call }.to raise_exception LeaveEventService::Error, "Owner can't leave his own events!"
  end

  it "raises NotOpen Error" do
    service = described_class.new(closed_event, user)

    expect { service.call }.to raise_exception LeaveEventService::Error, "You can only leave open events!"
  end
end
