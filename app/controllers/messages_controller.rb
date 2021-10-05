class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @message = Message.new
    # @messages = Message.where(room_id: params[:room_id]).order(created_at: :DESC).includes(:user)
    @messages = @room.messages.includes(:user)
  end
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end
  private
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
