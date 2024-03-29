# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar

  validate :avatar_image_content_type, if: -> { avatar.attached? }

  private

  def avatar_image_content_type
    extension = ['image/png', 'image/jpg', 'image/gif']
    errors.add(extension.join(', '), " 以外の拡張子が指定されています。") unless avatar.content_type.in?(extension)
  end
end
