require 'rails_helper'

RSpec.describe Category, :type => :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to ensure_length_of(:slug).is_at_most(255) }
  end

  describe "associations" do
    it { is_expected.to have_many(:contents) }
  end

  describe ".create_defaults" do
    context "pt-BR locale" do
      before do
        I18n.locale = "pt-BR"
        described_class.create_defaults!
      end

      let(:expected_ptbr) do
        [
          "Eventos",
          "Inovações",
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

      it { expect(described_class.all.map(&:name)).to match_array(expected_ptbr) }
    end

    context "es locale" do
      before do
        I18n.locale = "es"
        described_class.create_defaults!
      end

      let(:expected_es) do
        [
          "Eventos",
          "Innovaciones",
          "Comunidad",
          "Especificaciones",
          "Editorial",
          "Noticias",
          "Literatura",
          "Estandarización",
          "Entrenamiento",
          "El bueno y lo malo"
        ]
      end

      it { expect(described_class.all.map(&:name)).to match_array(expected_es) }
    end

  end
end
