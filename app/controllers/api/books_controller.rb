class Api::BooksController < ApplicationController
  before_action :set_book, only: %i[show update destroy]
  before_action :authenticate_user!

  def index
    @books = current_user.books

    render json: @books
  end

  def show
    render json: @book
  end

  def create
    @book = current_user.books.new(book_params)

    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book, status: :accepted
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :current_chapter, :category, :num_of_pages, :current_page)
  end
end
