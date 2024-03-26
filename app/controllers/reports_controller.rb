class ReportsController < ApplicationController
  before_action :set_report, only: %i[show destroy]

  def index
    @reports = Report.order(:id).page(params[:page]).per(3)
  end

  def new
    @report = Report.new
  end

  def show; end

  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to reports_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url notice: :report_is_deleted }
      format.json { head :no_content }
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
