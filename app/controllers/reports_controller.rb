# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

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

  def edit; end

  def create
    begin
      ActiveRecord::Base.transaction do
        @report = current_user.reports.create!(create_params)
        @report.mention_reports!(mentioning_reports)
      end

      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    rescue
      flash.now[:alert] = t('errors.create_error_occurred')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @report.update(update_params)

      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    rescue
      flash.now[:alert] = t('errors.update_error_occurred')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def create_params
    params.require(:report).permit(:title, :content)
  end

  def update_params
    params.require(:report).permit(:title, :content).merge(mentioning_report_ids: mentioning_reports)
  end

  def mentioning_reports
    url_arrays = create_params[:content].scan(/(http:\/\/localhost:3000\/reports)\/([0-9]+)/)
    url_arrays.filter_map { |url_array| url_array[1].to_i }
  end
end
