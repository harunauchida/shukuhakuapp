class User < ApplicationRecord
  has_one_attached :icon   # ←これでユーザーごとに1枚のアイコンを保存できる
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

   # 必須項目のバリデーション
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  
end
