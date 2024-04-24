# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    user = User.new
    report = Report.new(user:)

    assert report.editable?(user)

    another_user = User.new
    assert_not report.editable?(another_user)
  end

  test '#created_on' do
    report = Report.new(created_at: Time.zone.local(2024, 4, 1, 0, 0, 0))
    assert_equal Date.new(2024, 4, 1), report.created_on
  end

  test '#save_mentions' do
    user = User.create!(email: 'Hoge@sample.com', password: 'password')
    first_report = Report.create!(user:, title: 'Title', content: 'first report')
    second_report = Report.create!(user:, title: 'Title', content: 'http://localhost:3000/reports/')
    assert_equal [], second_report.mentioning_reports

    third_report = Report.create!(user:, title: 'Title', content: "http://localhost:3000/reports/#{first_report.id}")
    assert_equal [first_report], third_report.mentioning_reports

    third_report.update!(content: 'deleted mention')
    assert_equal [], third_report.reload.mentioning_reports
  end
end
