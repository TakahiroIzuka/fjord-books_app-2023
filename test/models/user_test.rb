# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user = User.new(email: 'hoge@example.com', name: '')
    assert_equal 'hoge@example.com', user.name_or_email

    user.name = 'Hoge'
    assert_equal 'Hoge', user.name_or_email
  end
end
