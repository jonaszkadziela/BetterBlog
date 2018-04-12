module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert my-alert-notice"
    when :error then "alert my-alert-error"
    end
  end
end