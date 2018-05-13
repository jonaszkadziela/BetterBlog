module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert my-alert-notice"
    when :alert then "alert my-alert-danger"
    end
  end

  def markdown(content)
    markdown_options = {
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      disable_indented_code_blocks: true,
      lax_spacing: true,
      strikethrough: true,
      footnotes: true
    }
    renderer_options = {
      hard_wrap: true,
      filter_html: true
    }

    renderer = HTMLwithPygments.new(renderer_options)
    Redcarpet::Markdown.new(renderer, markdown_options).render(content).html_safe
  end

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end
end