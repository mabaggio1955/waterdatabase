class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  has_many :contents
end
