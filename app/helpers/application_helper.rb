module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: "alert-success error-message",
      error: "alert-danger error-message",
      alert: "alert-warning error-message",
      notice: "alert-info error-message"
    }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(*)
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
               concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
               concat message
             end)
    end
    nil
  end

  def input_red_border?
    flash.alert.include?("Invalid email or password.") unless flash.alert.nil?
  end
end
