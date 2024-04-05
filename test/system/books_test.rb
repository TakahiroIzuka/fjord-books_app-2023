# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)

    visit root_path
    @user = users(:alice)
    sign_in @user
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test 'should create book' do
    visit books_url
    click_on '本の新規作成'

    fill_in 'メモ', with: 'New memo'
    fill_in 'タイトル', with: 'New title'
    click_on '登録'

    assert_text '本が作成されました。'
    assert_text 'New title'
    assert_text 'New memo'
  end

  test 'should update Book' do
    visit book_url(@book)
    click_on 'この本を編集'

    fill_in 'メモ', with: 'Updated memo'
    fill_in 'タイトル', with: 'Updated title'
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text 'Updated title'
    assert_text 'Updated memo'
  end

  test 'should destroy Book' do
    visit book_url(@book)
    click_on 'この本を削除'

    assert_text '本が削除されました。'
  end
end
