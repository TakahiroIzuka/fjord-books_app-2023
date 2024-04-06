# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to @comment.commentable, notice: 'コメントを投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    if @comment.user_id != current_user.id
      redirect_to @commentable, alert: '他のユーザーのコメントは削除できません'
    elsif @comment.destroy
      redirect_to @commentable, notice: 'コメントを削除しました'
    else
      render :destroy, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
