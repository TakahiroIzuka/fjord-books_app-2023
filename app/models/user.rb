# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  has_one :report, dependent: :destroy
  has_many :comment, dependent: :destroy

  def display_name
    self.name != '' ? self.name : self.email
  end
end
