require 'spec_helper'

describe UserMailer do
  describe 'User Mailer' do
    before :each do
      @user = FactoryGirl.create(:user)
      @event = FactoryGirl.create(:event, status: :open, people_amount: 2)
      FactoryGirl.create(:participation, user: @user, event: @event)
    end

    let(:newsletter_notification) { UserMailer.event_new_notification(@event) }
    let(:close_notification) { UserMailer.event_close_notification(@event, @user) }
    let(:expire_notification) { UserMailer.event_expire_notification(@event) }
    let(:extend_notification) { UserMailer.event_extend_notification(@event) }

    it "sends newsletter notification email" do
      expect do
        newsletter_notification.deliver_later
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "sends close event notification email" do
      expect do
        close_notification.deliver_later
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "sends expire event notification email" do
      expect do
        expire_notification.deliver_later
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "sends extend event notification email" do
      expect do
        extend_notification.deliver_later
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'renders the subject' do
      expect(close_notification.subject).to eql('Event you have participated in reached ' \
      'required number of participants!')
    end

    it 'renders the receiver email' do
      expect(close_notification.to).to eql([@user.email])
    end
  end
end
