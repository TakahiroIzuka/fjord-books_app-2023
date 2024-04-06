# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit
    @report = current_user.reports.find(params[:id])
  end

  def create
    @report = current_user.reports.create(create_params)

    if @report.mention_reports(mentioning_reports) && @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @report = current_user.reports.find(params[:id])

    ActiveRecord::Base.transaction do
      @report.update(update_params)

      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    rescue StandardError
      flash.now[:alert] = t('errors.update_error_occurred')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report = current_user.reports.find(params[:id])
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def create_params
    params.require(:report).permit(:title, :content)
  end

  def update_params
    params.require(:report).permit(:title, :content).merge(mentioning_report_ids: mentioning_reports)
  end

  def mentioning_reports
    url_arrays = create_params[:content].scan(%r{(http://localhost:3000/reports)/([0-9]+)})
    url_arrays.filter_map { |url_array| url_array[1].to_i }
  end
end
