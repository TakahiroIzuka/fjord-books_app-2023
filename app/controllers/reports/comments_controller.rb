# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  def new
    super
    @commentable = Report.find(params[:report_id])
  end

  def create
    @commentable = Report.find(params[:report_id])
    super
  end

  def destroy
    @commentable = Report.find(params[:report_id])
    super
  end
end
