class Content < ActiveRecord::Base
  validates :title, :locale, presence: true
  validates :title, :locale, length: { maximum: 255 }
end
