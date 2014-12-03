class Content < ActiveRecord::Base
  validates :title, :locale, presence: true
  validates :title, :locale, length: { maximum: 255 }

  default_scope -> { where(locale: I18n.locale) }
end
