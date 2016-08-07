describe JoinEventService do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }

  it "is successful" do
    service = described_class.new(event, user)

    event = service.call
    expect(event.participations.count).to eq 1
  end

  it "raises AlreadyMember Error" do
    FactoryGirl.create(:participation, user: user, event: event)
    service = described_class.new(event, user)

    expect { service.call }.to raise_exception JoinEventService::Error, "You're already member of this event!"
  end

  it "raises NotOpen Error" do
    event = FactoryGirl.create(:event, :closed)
    user = FactoryGirl.create(:user)

    service = described_class.new(event, user)

    expect { service.call }.to raise_exception JoinEventService::Error, "Event is already closed!"
  end

  it "raises AlreadyFull Error" do
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)
    service = described_class.new(event, user3)

    expect { service.call }.to raise_exception JoinEventService::Error, "Event is full!"
  end
end
