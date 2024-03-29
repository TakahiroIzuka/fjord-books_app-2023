# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  def posted_date
    created_at.strftime('%Y/%m/%d %H:%M')
  end
end
