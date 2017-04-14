class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         #セッションタイムアウト伸ばす
         :timeoutable

  has_many :habits
  # パスワードなし更新したいが倍デーションはかけたい
  # validates :password, presence: true
  # validates :password_confirmation, presence: true

  def update_account_without_password(params)
    # DBカラムに現在のパスワードが無いので削除する
    params.delete(:current_password)
    # パスワード入力が無ければパスワード無しで更新できるようにする
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update_attributes(params)
    #入力したパスワードと確認用パスワードをフィールドに表示しないようnilにする
    clean_up_passwords
    result
  end
end
