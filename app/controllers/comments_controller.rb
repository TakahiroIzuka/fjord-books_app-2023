# frozen_string_literal: true

class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    reise NotImplementedError
  end

  def destroy
    reise NotImplementedError
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def set_commentable
    raise NotImplementedError
  end
end
