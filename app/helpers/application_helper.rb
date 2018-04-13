module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert my-alert-notice"
    when :danger then "alert my-alert-danger"
    end
  end
end