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

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def mention_reports(report_ids)
    report_ids.each do |report_id|
      mention(report_id)
    end
  end

  def self.mentioning_report_ids(content)
    report_ids = content.scan(%r{(http://localhost:3000/reports)/([0-9]+)})
    report_ids.filter_map { |url_array| url_array[1].to_i }.uniq
  end

  private

  def mention(other_report_id)
    active_reports.create(mentioning_report_id: other_report_id)
  end
end
