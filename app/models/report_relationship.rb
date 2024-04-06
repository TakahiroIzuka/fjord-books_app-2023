# frozen_string_literal: true

class ReportRelationship < ApplicationRecord
  belongs_to :report
  belongs_to :mentioning_report, class_name: 'Report'

  validate :not_self_mention

  private

  def not_self_mention
    errors.add(:could_not_mention_oneself) if report_id == mentioning_report_id
  end
end
