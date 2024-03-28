# frozen_string_literal: true

class Books::CommentsController < CommentsController
  before_action :set_book, only: %i[new create]

  def create
    @comment = @book.comments.new(comment_params)
    if @comment.save
      redirect_to @comment.commentable, notice: 'コメントを投稿しました'
    else
      redirect_to book_path(@book)
    end
  end


  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
