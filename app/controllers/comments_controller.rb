# frozen_string_literal: true

class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    reise NotImplementedError
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
