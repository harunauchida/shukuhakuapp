class Room < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :detail, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :address, presence: true
  has_many :reservations, dependent: :destroy
  has_one_attached :image  # 任意で画像を添付できる
end
