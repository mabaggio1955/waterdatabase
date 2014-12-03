class Content < ActiveRecord::Base
  validates :title, :locale, presence: true
  validates :title, :locale, length: { maximum: 255 }
  belongs_to :category
  has_many :documents, dependent: :destroy

  default_scope -> { where(locale: I18n.locale) }
end
