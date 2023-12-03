class Post < ApplicationRecord
  # override this method, so that Rails will uses `slug` instead
  # of `id` as default parameter while using `link_to` or `form_with`.
  # https://gist.github.com/cdmwebs/1209732
  def to_param
    slug
  end

  belongs_to :user

  validates :title, :body_markdown, presence: true
  before_create :set_slug
  before_save :set_body_html

  enum :category, [:articles, :codewar, :tips], default: :articles

  default_scope { where("published_at <= ?", Time.current) }

  def markdown_to_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       space_after_headers: true)
    markdown.render(body_markdown).html_safe
  end

  private

    def set_slug
      self.slug = title.strip.gsub(/[[:punct:]]/, '-').downcase unless slug.present?
    end

    def set_body_html
      self.body_html = markdown_to_html
    end

end
