class AchivementsController < ApplicationController

  def update
    achivement = Achivement.find(params[:id])
    if achivement.blank?
      render json: { status: "error" }
    end
    achivement.completed = update_params[:checked]
    if achivement.save
      render json: { status: "success" }
    else
      render json: { status: "error" }
    end
  end

  def save_memo
    redirect_to root_url if memo_params[:memo].empty?
    today_date = Time.zone.today.strftime('%Y-%m-%d')
    # 検索条件と初期化したいオブジェクトのAttributeと同じ場合はfind_or_initialize_by
    # 検索条件と初期化したオブジェクトが違う場合はfind_or_initialize
    achivement = Achivement.find_or_create_by(habit_id: save_params[:habit_id], date: today_date) do |data|
      data.memo = save_params[:memo]
    end
    if achivement.update(memo: save_params[:memo])
      #成功
    else
      #失敗
    end
  end

  private

    def update_params
      params.require(:achivement).permit(:checked)
    end

    def save_params
      params.require(:achivement).permit(:habit_id, :memo)
    end
end
