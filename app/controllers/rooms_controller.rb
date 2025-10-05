class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to @room, notice: "施設を登録しました"
    else
      render :new
    end
  end

  def show
  end

  # 🔍 検索処理
  def search
    @rooms = Room.all

    # エリア検索（住所を対象としたあいまい検索）
    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "#{params[:area]}%")
    end

    # フリーワード検索（施設名・詳細のあいまい検索）
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @rooms = @rooms.where("name LIKE ? OR detail LIKE ?", keyword, keyword)
    end

    # 件数を取得
    @count = @rooms.count
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: "施設情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "施設を削除しました"
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :detail, :price, :address, :image, :destroy)
  end
end
