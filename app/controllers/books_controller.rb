class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
    @books = @books.where(year: params[:year]) if params[:year].present?
    @books = @books.where(month: params[:month]) if params[:month].present?
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    book_params = params.require(:book).permit(:year, :month, :inout, :category, :amount)
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "登録しました"
      redirect_to books_path
    else
      flash.now[:alert] = "失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    book_params = params.require(:book).permit(:year, :month, :inout, :category, :amount)
    if @book.update(book_params)
      flash[:notice] = "更新しました"
      redirect_to books_path
    else
      flash.now[:alert] = "失敗しました"
      render :edit
    end
  end
  
  def destroy
    @book.destroy
    flash[:notice] = "削除しました"
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

end
