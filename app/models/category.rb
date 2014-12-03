class Category < ActiveRecord::Base
  validates :name, :locale, presence: true
  validates :name, :locale, length: { maximum: 255 }
  has_many :contents

  default_scope -> { where(locale: I18n.locale) }
end
