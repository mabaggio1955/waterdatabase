class Content < ActiveRecord::Base
  validates :title, :locale, presence: true
  validates :title, :locale, length: { maximum: 255 }
  belongs_to :category

  default_scope -> { where(locale: I18n.locale) }
end
