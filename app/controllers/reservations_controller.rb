class ReservationsController < ApplicationController
  before_action :set_room, only: [:new, :create, :confirm]
  before_action :set_reservation, only: [:destroy]

  # ----------------------------
  # トップページ用：自分の予約一覧
  # ----------------------------
  def index
    @reservations = current_user.reservations.order(created_at: :desc)
  end

  # ----------------------------
  # 新規予約
  # ----------------------------
  def new
    @reservation = @room.reservations.new
  end

  # ----------------------------
  # 予約確認
  # ----------------------------
  def confirm
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user  # 現在ログイン中のユーザーを紐づけ
    if @reservation.valid?
      @nights = (@reservation.check_out - @reservation.check_in).to_i
      @total_price = @room.price * @nights * @reservation.number_of_people
      render :confirm
    else
      flash.now[:alert] = @reservation.errors.full_messages.join(", ")
      render :new
    end
  end

  # ----------------------------
  # 予約作成
  # ----------------------------
  def create
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user  # 現在ログイン中のユーザーを紐づけ
    if @reservation.save
      redirect_to reservations_path, notice: "予約が完了しました" # トップページ用の自分の予約一覧へ
    else
      flash.now[:alert] = @reservation.errors.full_messages.join(", ")
      render :new
    end
  end


  private

  def set_room
    @room = Room.find(params[:room_id]) if params[:room_id]
  end

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_people)
  end
end
