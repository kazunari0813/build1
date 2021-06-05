class MessagesController < ApplicationController

	before_action :authenticate_user!

  def create
    if current_user.entries.where(room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params_with_current_user_id)
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
		redirect_to room_path(@message.room_id)
  end

  private
  def message_params
  	params.require(:message).permit(:user_id, :message, :room_id)
  end
  def message_params_with_current_user_id
  	message_params.merge(user_id: current_user.id)
  end
end
