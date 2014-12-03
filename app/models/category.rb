class Category < ActiveRecord::Base
  validates :name, :locale, presence: true
  validates :name, :locale, length: { maximum: 255 }
  has_many :contents

  default_scope -> { where(locale: I18n.locale) }

  class << self
    def create_defaults!
      create_locale_ptbr_defauls!
      create_locale_es_defauls!
    end

    private

    def create_locale_ptbr_defauls!
      [
        "Eventos",
        "Inovações em tecnologia",
        "Comunidade",
        "Especificações",
        "Editora",
        "Notícias",
        "Literatura",
        "Padronização",
        "Treinamentos",
        "O certo e o errado"
      ].each do |name|
        self.unscoped.find_or_initialize_by(name: name, locale: :"pt-BR").save!
      end
    end

    def create_locale_es_defauls!
      [
        "Eventos",
        "Las innovaciones en la tecnología",
        "Comunidad",
        "Especificaciones",
        "Editorial",
        "Noticias",
        "Literatura",
        "Estandarización",
        "Entrenamiento",
        "El bien y el mal"
      ].each do |name|
        self.unscoped.find_or_initialize_by(name: name, locale: :es).save!
      end
    end
  end
end
