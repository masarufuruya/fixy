class MemosController < ApplicationController
  before_action :set_memo, only: [:update]

  def show
    @memo = Memo.find_by(habit_id: params[:habit_id], achivement_id: params[:achivement_id])
    if @memo
      render json: { id: @memo.id, body: @memo.body }
    else
      render json: { body: "" }
    end
  end

  #メモ保存
  def create
    memo = Memo.new(memo_params)
    if memo.save
      render json: { status: 'success', id: memo.id, achivement_id: params[:achivement_id] }
    else
      render json: { status: 'error' }
    end
  end

  def update
    if @memo.update(memo_params)
      render json: { status: 'success', id: @memo.id, achivement_id: params[:achivement_id] }
    else
      render json: { status: 'error' }
    end
  end

  private

    def set_memo
      @memo = Memo.find(params[:id])
    end

    def memo_params
      params.require(:memo).permit(:body).merge(habit_id: params[:habit_id], achivement_id: params[:achivement_id])
    end
end
