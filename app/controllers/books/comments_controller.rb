# frozen_string_literal: true

class Books::CommentsController < CommentsController
  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to @comment.commentable, notice: 'コメントを投稿しました'
    else
      redirect_to book_path(@commentable)
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    redirect_to book_path(@commentable), alert: '他のユーザーのコメントは削除できません' if @comment.user_id != current_user.id

    @comment.destroy
    redirect_to book_path(@commentable), notice: 'コメントを削除しました'
  end

  private

  def set_commentable
    @commentable = Book.find(params[:book_id])
  end
end
