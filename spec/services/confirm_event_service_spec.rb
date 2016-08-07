describe ConfirmEventService do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }

  it "is successful" do
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)

    event.status = :closed

    service = described_class.new(event, user)
    response = service.call

    expect(response[:event].status).to eq "done"
  end

  it 'increases counter for every participant' do
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)

    event.status = :closed

    described_class.new(event, user).call

    user.reload
    user2.reload

    correct_counter = (user.coffee_counter == 1 && user2.coffee_counter == 1)
    expect(correct_counter).to be_truthy
  end

  it "raises NotMember Error" do
    service = described_class.new(event, user)

    expect { service.call }.to raise_exception ConfirmEventService::Error, "You can't confirm event that you're not member of!"
  end

  it "raises NotClosed Error" do
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)

    service = described_class.new(event, user)

    expect { service.call }.to raise_exception ConfirmEventService::Error, "You can confirm only closed event!"
  end

  it "raises invalid NotValidEvent" do
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)

    event.status = :closed

    event.description = nil
    service = described_class.new(event, user)
    expect { service.call }.to raise_exception ConfirmEventService::Error, "Event is invalid!"
  end
end
