module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert my-alert-notice"
    when :alert then "alert my-alert-danger"
    end
  end

  def markdown(content)
    options = {
      hard_wrap: true,
      filter_html: true,
      tables: true,
      autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }

    renderer = HTMLwithPygments.new()
    Redcarpet::Markdown.new(renderer, options).render(content).html_safe
  end

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end
end