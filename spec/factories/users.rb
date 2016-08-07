# == Schema Information
#
# Table name: users
#
#  id                          :integer          not null, primary key
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  reset_password_token        :string
#  reset_password_sent_at      :datetime
#  remember_created_at         :datetime
#  sign_in_count               :integer          default(0), not null
#  current_sign_in_at          :datetime
#  last_sign_in_at             :datetime
#  current_sign_in_ip          :inet
#  last_sign_in_ip             :inet
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  coffee_counter              :integer          default(0), not null
#  newsletter                  :boolean          default(FALSE), not null
#  temporary_newsletter        :boolean          default(FALSE), not null
#  temporary_newsletter_status :boolean          default(FALSE), not null
#  remember_token              :string
#

# spec/factories/users,rb

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    coffee_counter 0
    newsletter true
    temporary_newsletter false
    temporary_newsletter_status false
  end
end
