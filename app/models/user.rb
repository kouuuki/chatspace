class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :groups, through: :members
  has_many :members, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name,presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 10 }
end
