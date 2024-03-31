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
        @report = current_user.reports.create!(report_params)
        @report.mention_reports!(mentioning_reports)
      end

      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    rescue => e
      p e.message
      flash.now[:alert] = t('controllers.common.alert_create', name: Report.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
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

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def mentioning_reports
    url_arrays = report_params[:content].scan(/(http:\/\/localhost:3000\/reports)\/([0-9]+)/)
    url_arrays.filter_map { |url_array| url_array[1].to_i }
  end
end
