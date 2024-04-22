module ApplicationHelper
  def flash_message
    messages = ""
    flash_types = { notice: "success", info: "info", warning: "warning", error: "danger" }
    
    flash_types.each {|type, alert_type|
      if flash[type]
        messages += "<div class=\"alert alert-#{alert_type}\" role='alert'>#{flash[type]}</div>"
      end
    }
    messages.html_safe
  end  
end
