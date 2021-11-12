# require 'rails_helper'
 #require 'factory_bot'
 require 'factories/articles'



RSpec.describe Article, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  #  it "test a number to be positive" do
  #    expect(1).to be_positive #be_positive => 1.positive? ==true
  #    expect(5).to be > 3
  #  end

 # it 'test article object' do
 #   #article = FactoryBot.create(:article)
 #   article = create(:article)
 #   expect(article.title).to eq('Sample article')
 # end

    #foi criado o bot em /spec/factories/articles.rb
        #FactoryBot.define do
        #  factory :article do
        #    title { "Sample article" }
        #    contente { "Sample Content" }
        #    slug { "sample-article" }
        #  end
        #end

    ## expect ( value) . to (matcher)
  describe '#validations' do

    let(:article) { build(:article)}

    it 'tests that factory is valid' do
      #article = build(:article)
      expect(article).to be_valid
    end

    it 'has an invalid title' do
      #article = build(:article,title:'')
      article.title = ""
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end
  end


end
