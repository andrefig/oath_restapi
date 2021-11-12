require 'rails_helper'
#require 'factory_bot'
require 'factories/articles'



RSpec.describe Article, type: :model do
  describe '#validations' do
    let(:article) { build(:article) }

    it 'tests that factory is valid' do
      expect(article).to be_valid
      article.save!
      #verifica se o primeiro é válido

      another_article = build(:article)
      expect(another_article).to be_valid
      #verifica se o segundo é válido - é feita uma alteração na factory pra gerar valores diferentes a cada iteração
    end

    it 'has an invalid title' do
      article.title = ''
      expect(article).not_to be_valid
      #O esperado é que dê erro. o título não pode ser vazio...

      expect(article.errors[:title]).to include("can't be blank")
      # o texto aqui é comparado com a mensagem de erro gerada!
    end

    it 'has an invalid content' do
      article.content = ''
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end

    it 'has an invalid slug' do
      article.slug = ''
      expect(article).not_to be_valid
      expect(article.errors[:slug]).to include("can't be blank")
    end

    it 'validates the uniqueness of the slug' do
      article1 = create(:article)
      expect(article1).to be_valid

      article2 = build(:article, slug: article1.slug)
      #Cria outro artigo e faz ter o mesmo slug do primeito

      expect(article2).not_to be_valid
      #Como o slug é repetido, espera-se que dê erro

      expect(article2.errors[:slug]).to include('has already been taken')
      # o texto aqui é comparado com a mensagem de erro gerada!

    end
  end

  #testa Article.recent
  
  describe '.recent' do 
    it 'returns articles in the correct order' do
      #Cria artigos com horas de criacao diferentes e compara
      older_article = create(:article, created_at: 1.hour.ago)
      recent_article = create(:article)

      expect(described_class.recent).to eq(
          [recent_article,older_article]
        )

      #altera os horarios de criacao e verifica novamente
      recent_article.update_column(:created_at, 2.hours.ago)
      expect(described_class.recent).to eq(
          [older_article,recent_article]
        )
    end
  end
end