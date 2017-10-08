class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :body,presence: true
  validates :body, length: { maximum: 1000 }

  mount_uploader :image, ImageUploader
end
