require 'rails_helper'
#em rails_helper...
# RSpec.configure do |config|
# config.include FactoryBot::Syntax::Methods
# => adicionar:
# =>   config.include ApiHelpers

RSpec.describe "Articles", type: :request do
  describe '#index' do 
    it 'returns a sucess response' do
      get '/articles'
      #expect(response.status).to eq(200) #HTTP Sucess
      expect(response).to have_http_status(:ok)
    end

    it 'returns articles in the proper order' do
      older_article = create(:article, created_at: 1.hour.ago)
      recent_article = create(:article)
      get '/articles'
      ids = json_data.map {|item| item[:id].to_i}
      expect(ids).to(
        eq([recent_article.id,older_article.id])
      )
    end

    it 'returns a proper JSON' do
        article = create :article
        get '/articles'

         #novo expect - ver support/apo_helpers.rb
        expect(json_data.length).to eq(1)
        expected_data = json_data.first 
        aggregate_failures do 
          expect(expected_data[:id]).to eq(article.id.to_s)
          expect(expected_data[:type]).to eq('article')
          expect(expected_data[:attributes]).to eq(
            title: article.title,
            content: article.content,
            slug: article.slug) 
        end


        ###simbolize_keys - chaves como simbolos e nao strings
        ##body = JSON.parse(response.body).deep_symbolize_keys
        # #novo expect - ver support/apo_helpers.rb
        # #expect(body).to eq(
        # expect(json_data).to eq(
        # #  data:
        #   [
        #     {
        #       id: article.id.to_s,
        #       type: 'article',
        #       attributes: 
        #       {
        #         title: article.title,
        #         content: article.content,
        #         slug: article.slug
        #       }
        #     }
        #   ]
        #   )
    end

    it 'paginates results' do
      #cria tres articles
      article1,article2,article3 = create_list(:article,3)
      #solicita a primeira pagina da lista json com paginas de tamanho 1
      get '/articles', params: {page: {number: 2, size: 1}}
      #tamanho 1
      expect(json_data.length).to eq(1)
      #primeiro elemento da pagina solicitada = 2
      expect(json_data.first[:id]).to eq(article2.id.to_s)
    end

    it 'contains pagination links' do
      #cria tres articles
      article1,article2,article3 = create_list(:article,3)
      #solicita a primeira pagina da lista json com paginas de tamanho 1
      get '/articles', params: {page: {number: 2, size: 1}}
      #os 5 links especificados existem
      expect(json[:links].length).to eq(5)
      #
      expect(json[:links].keys).to contain_exactly(
        :first,:prev,:next,:last,:self
        )
    end

  end

  # pending 'create' do 
  #   # it 'returns a sucess response' do 
  #   #   post '/articles'
  #   #   #expect(response.status).to eq(200) #HTTP Sucess
  #   #   expect(response).to have_http_status(:ok)
  #   # end
  # end
end
