module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert my-alert-info"
    when :success then "alert my-alert-info"
    when :error then "alert my-alert-error"
    when :alert then "alert my-alert-error"
    end
  end
end