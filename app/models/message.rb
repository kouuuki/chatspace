class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :body,presence: true
  validates :body, length: { maximum: 300 }

  mount_uploader :image, ImageUploader
end
