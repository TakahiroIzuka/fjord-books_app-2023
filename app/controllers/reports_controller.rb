# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @reports = Report.order(:id).page(params[:page]).per(3)
  end

  def new
    @report = Report.new
  end

  def show
    @report = Report.find(params[:id])
    @current_user = current_user
  end

  def edit
    @report = Report.find(params[:id])
    return unless created_by_current_user?(:edit)

    @report
  end

  def create
    @report = Report.new(report_params.merge({ user_id: current_user.id }))

    if @report.save
      redirect_to report_path(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      flash[:alert] = t('controllers.common.alert_create', name: Report.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @report = Report.find(params[:id])
    return unless created_by_current_user?(:update)

    if @report.update!(report_params)
      redirect_to report_path(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      flash[:alert] = t('controllers.common.alert_update', name: Report.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report = Report.find(params[:id])
    return unless created_by_current_user?(:destroy)

    if @report.destroy
      redirect_to reports_path, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
    else
      flash[:alert] = t('controllers.common.alert_destroy', name: Report.model_name.human)
      render :destroy, status: :unprocessable_entity
    end
  end

  private

  def created_by_current_user?(witch_action)
    return true if @report.created_by?(current_user)

    flash[:alert] = t("controllers.common.alert_#{witch_action}_authorization_error", name: Report.model_name.human)
    redirect_to report_path(@report)
    false
  end

  def report_params
    params.require(:report).permit(:title, :description)
  end
end
