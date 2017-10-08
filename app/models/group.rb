class Group < ApplicationRecord
    has_many :users, through: :members
    has_many :members, dependent: :destroy
    has_many :messages, dependent: :destroy

    accepts_nested_attributes_for :messages, allow_destroy: true

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :name, length: { maximum: 30 }
    #accepts_nested_attributes_for :members
end
