class ReportRelationship < ApplicationRecord
  belongs_to :report
  belongs_to :mentioning_report, class_name: 'Report'
  validates :report_id, presence: true
  validates :mentioning_report_id, presence: true
  validate :not_self_mention

  private

  def not_self_mention
    errors.add(:could_not_mention_oneself) if report_id == mentioning_report_id
  end
end
