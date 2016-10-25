Devise.setup do |config|
  config.mailer_sender = 'no-reply@coffee.club'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 8..72

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.secret_key = '4cc4daaa5a48ac234552b0c0d1d64a83a3173ac385bf64b4f2abfb6104210a8b633917c212b63e5a64e6f707721a595777145a1a4ddad72532a611e0963db9e3'
end
