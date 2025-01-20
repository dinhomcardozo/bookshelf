# define um modelo Book em Ruby on Rails, e tem como objetivo gerar um ID personalizado para cada livro antes de ser criado no banco de dados

class Book < ApplicationRecord
    before_create :generate_custom_id
    # before_update :set_updated_by
    #executado antes de um novo registro ser criado no DB / generate_custom_id: 
    has_one_attached :book_cover

    validates :title, :author, :genre, :year, presence: true

    GENRES = [
      "Ação e aventura",
      "Arte e Fotografia",
      "Autoajuda",
      "Autobiografia",
      "Biografia",
      "Ciências Biológicas",
      "Ciências Gerais",
      "Ciências Sociais",
      "Comédia",
      "Contos",
      "Crimes Reais",
      "Direito",
      "Distopia",
      "Drama",
      "Economia Política",
      "Empreendedorismo & Gestão",
      "Esportes & Educação Física",
      "Fantasia",
      "Ficção",
      "Ficção Policial",
      "Filosofia",
      "Gastronomia",
      "Geografia e Meio Ambiente",
      "Graphic Novel",
      "Guias e Tutoriais",
      "História",
      "Infantil",
      "Psicologia",
      "Religião & Espiritualidade",
      "Romance",
      "Sexo e Relacionamentos",
      "Tecnologia Digital",
      "Thriller, Horror e Suspense",
      "Outros"
    ].freeze

    validates :genre, inclusion: { in: GENRES }

    SUB_GENRES = [
      "Ação e aventura",
      "Arte e Fotografia",
      "Autoajuda",
      "Autobiografia",
      "Biografia",
      "Ciências Biológicas",
      "Ciências Gerais",
      "Ciências Sociais",
      "Comédia",
      "Contos",
      "Crimes Reais",
      "Direito",
      "Distopia",
      "Drama",
      "Economia Política",
      "Empreendedorismo & Gestão",
      "Esportes & Educação Física",
      "Fantasia",
      "Ficção",
      "Ficção Policial",
      "Filosofia",
      "Gastronomia",
      "Geografia e Meio Ambiente",
      "Graphic Novel",
      "Guias e Tutoriais",
      "História",
      "Infantil",
      "Psicologia",
      "Religião & Espiritualidade",
      "Romance",
      "Sexo e Relacionamentos",
      "Tecnologia Digital",
      "Thriller, Horror e Suspense",
      "Outros"
    ].freeze

    validates :sub_genre, inclusion: { in: SUB_GENRES }

    def self.ransackable_attributes(auth_object = nil)
      ["title", "author", "genre", "sub_genre", "year"]
    end

    private
  
    def generate_custom_id #gerar o ID personalizado para o livro
      letters = Array('A'..'Z').sample(4).join #Cria um array contendo todas as letras do alfabeto maiúsculo de A a Z / Seleciona aleatoriamente 4 letras desse array / Junta (join) essas 4 letras em uma única string
      numbers = rand(10000..99999).to_s #Gera um número aleatório da concatenação entre 10000 e 99999 / Converte o número gerado em uma string.
      self.book_id = "#{letters}#{numbers}" #método está atribuindo o valor gerado ao atributo book_id do objeto Book.
    end

end
