class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user

  # ----------------------------
  # バリデーション
  # ----------------------------
  validates :check_in, :check_out, :number_of_people, presence: true
  validates :number_of_people, numericality: { greater_than_or_equal_to: 1 }

  validate :check_in_date_cannot_be_in_the_past
  validate :check_out_after_check_in

  # ----------------------------
  # コールバック
  # ----------------------------
  before_save :calculate_total_price

  private

  # チェックインが「明日以降」になるように設定
  def check_in_date_cannot_be_in_the_past
    if check_in.present? && check_in <= Date.today
      errors.add(:check_in, "は明日以降の日付を選択してください")
    end
  end

  # チェックアウトがチェックインより後であることを確認
  def check_out_after_check_in
    if check_in.present? && check_out.present? && check_out <= check_in
      errors.add(:check_out, "はチェックインより後の日付を選択してください")
    end
  end

  # 宿泊料金の計算（例：1泊あたり room.price × 泊数 × 人数）
  def calculate_total_price
    return if check_in.blank? || check_out.blank? || number_of_people.blank?
    nights = (check_out - check_in).to_i
    self.total_price = room.price * nights * number_of_people
  end
end
