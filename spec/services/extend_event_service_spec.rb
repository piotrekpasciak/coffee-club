describe ExtendEventService do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  it "is successfull" do
    event = FactoryGirl.create(:event, :expired, owner: user)
    FactoryGirl.create(:participation, user: user, event: event)

    service = described_class.new(event, user)

    event = service.call
    expect(event.status).to eq "open"
  end

  it "sends mail upon success" do
    event = FactoryGirl.create(:event, :expired, owner: user)
    FactoryGirl.create(:participation, user: user, event: event)

    service = described_class.new(event, user)

    expect { service.call }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it "raises NotExpiredError" do
    event = FactoryGirl.create(:event, owner: user)
    FactoryGirl.create(:participation, user: user, event: event)

    service = described_class.new(event, user)
    expect { service.call }.to raise_exception ExtendEventService::Error, "You can extend only expired events!"
  end

  it "raises NotOwnerError" do
    event = FactoryGirl.create(:event, :expired, owner: user)
    FactoryGirl.create(:participation, user: user, event: event)

    service = described_class.new(event, user2)

    expect { service.call }.to raise_exception ExtendEventService::Error, "Only owner can extend expired event!"
  end

  it "raises NotValidError" do
    event = FactoryGirl.create(:event, :expired, owner: user)
    FactoryGirl.create(:participation, user: user, event: event)
    event.description = nil

    service = described_class.new(event, user)

    expect { service.call }.to raise_exception ExtendEventService::Error, "Event is invalid!"
  end
end
