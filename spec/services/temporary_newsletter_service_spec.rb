describe TemporaryNewsletterService do
  let(:user) { FactoryGirl.create(:user, temporary_newsletter_status: true) }

  it "sets flags for join action" do
    described_class.new(user, :join).call

    user.reload

    expect(user.temporary_newsletter).not_to eq true
  end

  it "sets flags for leave action" do
    described_class.new(user, :leave).call

    user.reload

    expect(user.temporary_newsletter).to eq true
  end

  it "sets flags for close action" do
    described_class.new(user, :close).call

    user.reload

    expect(user.temporary_newsletter_status).to eq false
  end
end
