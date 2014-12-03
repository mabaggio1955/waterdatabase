require 'rails_helper'

RSpec.describe Category, :type => :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:locale) }
    it { is_expected.to ensure_length_of(:name).is_at_most(255) }
    it { is_expected.to ensure_length_of(:locale).is_at_most(255) }
  end

  describe "associations" do
    it { is_expected.to have_many(:contents) }
  end

  describe "#locale" do
    it "has the current locale by default" do
      expect(subject.locale).to eq(I18n.locale)
    end
  end

  describe ".create_defaults" do
    before do
      described_class.create_defaults!
    end

    let(:expected_ptbr) do
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
      ]
    end

    let(:expected_es) do
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
      ]
    end

    it { expect(described_class.unscoped.where(locale: :"pt-BR").pluck(:name)).to match_array(expected_ptbr) }
    it { expect(described_class.unscoped.where(locale: :es).pluck(:name)).to match_array(expected_es) }
  end
end
