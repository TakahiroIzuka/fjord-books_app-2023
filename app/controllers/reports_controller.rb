class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = Report.order(:id).page(params[:page]).per(3)
  end

  def new
    @report = Report.new
  end

  def show; end

  def edit
    @report = Report.find(params[:id])

    if @report.author.id != current_user.id
      flash[:alert] = t('controllers.common.alert_edit_authorization_error', name: Report.model_name.human)
      redirect_to report_path(@report)
    end
  end

  def create
    @report = Report.new(report_params.merge({ user_id: current_user.id }))

    respond_to do |format|
      if @report.save
        format.html { redirect_to reports_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to report_url(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human) }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @report.author.id != current_user.id
      flash[:alert] = t('controllers.common.alert_destroy_authorization_error', name: Report.model_name.human)
      redirect_to report_path(@report)
    else
      @report.destroy

      respond_to do |format|
        format.html { redirect_to reports_url notice: :report_is_deleted }
        format.json { head :no_content }
      end
    end
 end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :description)
  end
end
