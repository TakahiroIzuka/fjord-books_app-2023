# frozen_string_literal: true

class ReportRelationship < ApplicationRecord
  belongs_to :report
  belongs_to :mentioning_report, class_name: 'Report'
end
