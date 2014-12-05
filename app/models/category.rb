class Category < ActiveRecord::Base
  validates :slug, presence: true
  validates :slug, length: { maximum: 255 }
  has_many :contents

  SLUGS = [
    "eventos",
    "inovacoes",
    "comunidade",
    "especificacoes",
    "editora",
    "noticias",
    "literatura",
    "padronizacao",
    "treinamentos",
    "o-certo-e-o-errado"
  ].freeze

  def name
    I18n.t("categories.name.#{self.slug}")
  end

  class << self

    def create_defaults!
      SLUGS.each do |slug|
        self.find_or_initialize_by(slug: slug).save!
      end
    end

  end
end
