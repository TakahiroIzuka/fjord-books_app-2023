class ReportRelationship < ApplicationRecord
  belongs_to :report
  belongs_to :mentioning_report, class_name: 'Report'
  validates :report_id, presence: true
  validates :mentioning_report_id, presence: true
end
