class Post < ApplicationRecord
  belongs_to :user

  validates :title, :body_markdown, presence: true
  before_create :set_slug
  before_save :set_body_html

  default_scope { where("published_at <= ?", Time.current) }

  def markdown_to_html(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       space_after_headers: true)
    markdown.render(text)
  end

  private

    def set_slug
      self.slug = title.gsub(/\s+/, '-') unless slug.present?
    end

    def set_body_html
      self.body_html = markdown_to_html(body_markdown)
    end

end
