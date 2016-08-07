describe CommentEventService do
  let(:user) { FactoryGirl.create :user }
  let(:user2) { FactoryGirl.create :user }
  let(:event) { FactoryGirl.create :event, :done }
  let(:open_event) { FactoryGirl.create :event }

  it "is successfull" do
    FactoryGirl.create(:participation, user: user, event: event)
    service = described_class.new(event, user, "Marvelous coffee")
    service.call

    expect(Comment.first.text).to eq "Marvelous coffee"
  end

  it "raises NotMemberError" do
    service = described_class.new(event, user, "Marvelous coffee")

    expect { service.call }.to raise_exception CommentEventService::Error, "Only member of event can comment it!"
  end

  it "raises NotDoneError" do
    FactoryGirl.create(:participation, user: user, event: open_event)
    service = described_class.new(open_event, user, "Marvelous coffee")

    expect { service.call }.to raise_exception CommentEventService::Error, "You can only comment done events!"
  end

  it "raises CommentInvalidError" do
    FactoryGirl.create(:participation, user: user, event: event)
    service = described_class.new(event, user, "")

    expect { service.call }.to raise_exception CommentEventService::Error, "Textarea cannot be empty!"
  end
end
