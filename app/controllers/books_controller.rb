#   Esse código é um exemplo de um controlador Rails, BooksController, que implementa controle de acesso para restringir certas ações aos administradores. 
class BooksController < ApplicationController #Define a classe BooksController, que herda de ApplicationController (gerencia as ações relacionadas ao recurso Book (livros), como listar, criar, editar ou excluir.)
    before_action :authenticate_user! #Filtros que são executados antes de certas ações do controlador. /authenticate_user! vem do Devise e garante que o usuário esteja autenticado antes de acessar qualquer método
    #before_action :check_admin, only: %i[new create edit update destroy] #filtro é aplicado apenas às ações: new, create, edit, update, e destroy (definido pelo only)
    before_action :set_book, only: %i[show edit update destroy]


    def index
      @books = Book.page(params[:page]).per(10) #substitui Books.all
      @q = Book.ransack(params[:q])
      @books = @q.result.page(params[:page])
    end
    
    def
      show
    end
    
    def new
      @book = Book.new
    end
    
    def create
      @book = Book.new(book_params)
        if @book.save
          redirect_to @book, notice: "Livro criado com sucesso."
        else
          render :new, status: :unprocessable_entity
        end
    end
    
    def
      edit
    end
    
    def update
      if @book.update(book_params)
          redirect_to @book, notice: "Livro atualizado com sucesso."
      else
          render :edit, status: :unprocessable_entity
      end
    end
    
    def destroy
      @book.destroy
      redirect_to books_path, notice: "Livro excluído com sucesso."
    end


    # Método para upload da planilha

    require 'csv'

    def bulk_upload
      # Apenas renderiza o formulário
    end

    def import
      if params[:file].present?
        file = params[:file]

        case File.extname(file.original_filename)
        when ".csv"
          import_csv(file)
        when ".xls", ".xlsx"
          import_xls(file)
        else
          redirect_to bulk_upload_books_path, alert: "Formato de arquivo não suportado. Use .csv, .xls ou .xlsx."
        end
      else
        redirect_to bulk_upload_books_path, alert: "Nenhum arquivo foi selecionado."
      end
    end


    private
  
    def check_admin #Verifica se o usuário atual (current_user) é um administrador: atributo admin deve estar definido como true no modelo User para que um usuário seja reconhecido como administrador.
      redirect_to root_path, alert: "Acesso negado." unless current_user.admin? #se não for admin será redirecionado para a root_path 
    end

    def set_book
      @book = Book.find(params[:id])
    end
    
    def book_params
      params.require(:book).permit(:title, :genre, :sub_genre, :author, :year, :book_cover)
    end

    # Métodos privados para upload da planilha

    def import_csv(file)
      CSV.foreach(file.path, headers: true) do |row|
        Book.create(row.to_hash)
      end
      redirect_to books_path, notice: "Livros importados com sucesso!"
    end
  
    def import_xls(file)
      spreadsheet = Roo::Spreadsheet.open(file.path)
      header = spreadsheet.row(1) # Primeira linha é o cabeçalho
  
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        Book.create(row)
      end
  
      redirect_to books_path, notice: "Livros importados com sucesso!"
    end

    
end
