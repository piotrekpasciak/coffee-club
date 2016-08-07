describe ExpireEventService do
  let(:user) { FactoryGirl.create(:user) }

  it "is successfull" do
    event = FactoryGirl.create(:event, time_length: 0)
    FactoryGirl.create(:participation, user: user, event: event)

    service = described_class.new(event)

    event = service.call
    expect(event.status).to eq "expired"
  end

  it "sends mail upon success" do
    event = FactoryGirl.create(:event, time_length: 0)
    FactoryGirl.create(:participation, user: user, event: event)

    service = described_class.new(event)

    expect { service.call }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it "raises NotOpenError" do
    event = FactoryGirl.create(:event, :closed)
    FactoryGirl.create(:participation, user: user, event: event)

    service = described_class.new(event)
    expect { service.call }.to raise_exception ExpireEventService::Error, "You can expire only open events!"
  end

  it "raises NotExpirableError" do
    event = FactoryGirl.create(:event)
    FactoryGirl.create(:participation, user: user, event: event)

    service = described_class.new(event)

    expect { service.call }.to raise_exception ExpireEventService::Error, "You can expire only events with no remaining time!"
  end

  it "raises NotValidError" do
    event = FactoryGirl.create(:event, time_length: 0)
    FactoryGirl.create(:participation, user: user, event: event)
    event.description = nil

    service = described_class.new(event)

    expect { service.call }.to raise_exception ExpireEventService::Error, "Event is invalid!"
  end
end
