describe CompleteEventService do
  let(:user) { FactoryGirl.create :user }
  let(:user2) { FactoryGirl.create :user }
  let(:event) { FactoryGirl.create :event, owner: user }

  it "is successfull" do
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)

    service = described_class.new(event, user)
    event = service.call

    expect(event.status).to eq "closed"
  end

  it "raises NotMemberError" do
    service = described_class.new(event, user)

    expect { service.call }.to raise_exception CompleteEventService::Error, "You can't complete event that you're not member of!"
  end

  it "raises NotOwnerError" do
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)

    service = described_class.new(event, user2)

    expect { service.call }. to raise_exception CompleteEventService::Error, "Only owner can complete event!"
  end

  it "raises EventNotOpenError" do
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)

    event.status = :closed
    service = described_class.new(event, user)

    expect { service.call }.to raise_exception CompleteEventService::Error, "You can complete only open and expired events!"
  end

  it "raises EventNotCompletableError" do
    FactoryGirl.create(:participation, user: user, event: event)

    service = described_class.new(event, user)

    expect { service.call }.to raise_exception CompleteEventService::Error, "You need at least one more participant to complete event!"
  end

  it "raises EventInvalidError" do
    FactoryGirl.create(:participation, event: event, user: user)
    FactoryGirl.create(:participation, event: event, user: user2)

    event.description = nil
    service = described_class.new(event, user)

    expect { service.call }.to raise_exception CompleteEventService::Error, "Event is invalid!"
  end
end
