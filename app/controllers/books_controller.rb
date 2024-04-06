# frozen_string_literal: true

class BooksController < ApplicationController
  # GET /books or /books.json
  def index
    @books = Book.order(:id).page(params[:page])
  end

  # GET /books/1 or /books/1.json
  def show
    @book = Book.find(params[:id])
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_path(@book), notice: t('controllers.common.notice_create', name: Book.model_name.human)
    else
      flash[:alert] = t('controllers.common.alert_create', name: Book.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to book_path(@book), notice: t('controllers.common.notice_update', name: Book.model_name.human)
    else
      flash[:alert] = t('controllers.common.alert_update', name: Book.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path, notice: t('controllers.common.notice_destroy', name: Book.model_name.human)
    else
      flash[:alert] = t('controllers.common.alert_destroy', name: Book.model_name.human)
      render :destroy, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :memo, :author, :picture)
  end
end
