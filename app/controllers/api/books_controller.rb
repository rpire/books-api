class Api::BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = current_user.books

    render json: @books
  end

  def show
    @book = Book.find(params[:id])

    render json: @book
  end
end
