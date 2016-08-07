Rails.application.configure do
  config.action_mailer.default_options = {from: 'no-reply@example.com'}


  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true

  config.action_mailer.delivery_method = :test if Rails.env.test?
end
