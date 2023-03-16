class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books
  def index
    @author = Author.find(params[:author_id])
    @books = @author.books
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @author = Author.find(params[:author_id])
    @book = @author.books.build
  end

  # GET /books/1/edit
  def edit
    @author = Author.find(params[:author_id])
  end

  # POST /books
  def create
    @author = Author.find(params[:author_id])
    @book = @author.books.build(book_params)

    if @book.save
      redirect_to "/authors/#{@author.id}/books", notice: "Book was successfully created."
    else
      render :new, status: :unprocessable_entity, alert: "Book was not created."
    end
  end

  # PATCH/PUT /books/1
  def update
    @author = Author.find(params[:author_id])
    
    if @book.update(book_params)
      redirect_to "/authors/#{@author.id}/books", notice: "Book was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @author = Author.find(params[:author_id])
    @book.destroy
    redirect_to "/authors/#{@author.id}/books", notice: "Book was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :published_date, :author_id)
    end
end
