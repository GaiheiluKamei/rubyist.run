class Post < ApplicationRecord
  include CodeHighlightable

  # override this method, so that Rails will uses `slug` instead
  # of `id` as default parameter while using `link_to` or `form_with`.
  # https://gist.github.com/cdmwebs/1209732
  def to_param
    slug
  end

  belongs_to :user

  validates :title, :body_markdown, presence: true
  validates_uniqueness_of :slug
  before_validation :set_slug, if: :title_changed?
  before_save :md_to_html, if: -> { body_markdown_changed? }

  enum :category, [:articles, :codewar, :tips], default: :articles

  scope :published, ->{ where("published_at <= ?", Time.current) }

  private

    def set_slug
      self.slug = title.parameterize
    end

end
