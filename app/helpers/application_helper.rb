module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert my-alert-notice"
    when :alert then "alert my-alert-danger"
    end
  end
end