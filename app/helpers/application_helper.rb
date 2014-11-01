module ApplicationHelper

  class PygmentsHTML < Redcarpet::Render::HTML
    def block_code code, language
    Pygments.highlight(code, :lexer => language)
    end
  end

  def markdown(text)
    coderayified = PygmentsHTML.new(
      with_toc_data: true,
      hard_wrap: true
    )
    options = {
      :no_intra_emphasis => true,
      :tables => true,
      :fenced_code_blocks => true,
      :autolink => true,
      :strikethrough => true,
      :lax_spacing => true,
      :superscript => true
    }
    markdown = Redcarpet::Markdown.new(coderayified, options)
    markdown.render(text).html_safe
  end

end
