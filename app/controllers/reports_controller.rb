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
    @report = current_user.reports.new(permitted_params)

    if @report.save!
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @report = current_user.reports.find(params[:id])

    begin
      @report.update!(permitted_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('controllers.common.not_found_error', name: Report.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report = current_user.reports.find(params[:id])
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def permitted_params
    params.require(:report).permit(:title, :content)
  end
end
