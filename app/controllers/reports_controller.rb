class ReportsController < ApplicationController
  before_action :set_report, only: %i[show]

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

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :description)
  end
end
