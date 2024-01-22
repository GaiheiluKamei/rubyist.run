require 'rouge/plugins/redcarpet'

module CodeHighlightable
  extend ActiveSupport::Concern

  included do
    before_save :md_to_html
  end

  protected

  # Rouge Theme Preview Page: https://spsarolkar.github.io/rouge-theme-preview/
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def md_to_html
    render_options = {
      filter_html:         true,
      space_after_headers: true,
      link_attributes: {rel: "nofollow", target: "_blank"}
    }
    renderer = HTML.new(render_options)

    extensions = {
      autolink:                     true,
      fenced_code_blocks:           true,
      disable_indented_code_blocks: true,
      no_intra_emphasis:            true,
      strikethrough:                true,
      superscript:                  true,
      highlight:                    true,
      tables:                       true,
      escape_html:                  true,
      quote:                        true,
      lax_spacing:                  true,
      hard_wrap:                    true,
    }

    self.body_html = Redcarpet::Markdown.new(renderer, extensions).render(body_markdown).html_safe
  end

end