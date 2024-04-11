# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_reports,
           class_name: 'ReportRelationship',
           dependent: :destroy,
           inverse_of: :report
  has_many :mentioning_reports, through: :active_reports, source: :mentioning_report

  has_many :passive_reports,
           class_name: 'ReportRelationship',
           foreign_key: 'mentioning_report_id',
           dependent: :destroy,
           inverse_of: :mentioning_report
  has_many :mentioned_reports, through: :passive_reports, source: :report

  validates :title, presence: true
  validates :content, presence: true

  before_save :set_mentioning_report_ids

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def set_mentioning_report_ids
    self.mentioning_report_ids = mentioned_report_ids(content)
  end

  private

  def mentioned_report_ids(content)
    report_ids = content.scan(%r{(http://localhost:3000/reports)/([0-9]+)})
    report_ids.filter_map { |url_array| url_array[1].to_i }.uniq
  end
end
