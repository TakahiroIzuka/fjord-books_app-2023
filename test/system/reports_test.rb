# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    @report = reports(:one)

    visit root_path
    @user = users(:alice)
    sign_in @user
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in '内容', with: 'New content'
    fill_in 'タイトル', with: 'New title'
    click_on '登録する'

    assert_text '日報が作成されました'
    assert_text 'New title'
    assert_text 'New content'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in '内容', with: 'Updated content'
    fill_in 'タイトル', with: 'Updated title'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text 'Updated title'
    assert_text 'Updated content'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
    assert_no_text @report.title
  end
end
