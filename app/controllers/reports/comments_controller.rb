# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  before_action :set_commentable, only: %i[new create delete]

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to @comment.commentable, notice: 'コメントを投稿しました'
    else
      redirect_to report_path(@commentable)
    end
  end

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end
end
