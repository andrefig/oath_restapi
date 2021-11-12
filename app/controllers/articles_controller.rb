class ArticlesController < ApplicationController
	include Paginable

	def index #define acao index
		#render json: Article.all
		#articles=Article.all

		##Article.recent definido no modelo article.rb
		## => scope :recent, -> {order(created_at: :desc)}
		articles=Article.recent


		#serializer - gera o json no formato adequado
		#paginator - gera as páginas conforme os parâmetros

		#render json: ArticleSerializer.new(articles).serializable_hash, status: :ok 

		#no módulo Paginable
		paginated = paginate(Article.recent)

		render_collection(paginated)


	end
	def show
		articles=Article.find(params.require(:id))
		render json: ArticleSerializer.new(articles).serializable_hash, status: :ok 
	end

	def create

	end
	# def serializer
	# 	ArticleSerializer
	# end


end