class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy]
  before_action :ensure_correct_user, only: [:index]
  before_action :authenticate_user!

  # GET /messages
  # GET /messages.json
  def index
    respond_to do |format|
      format.html
      format.json
    end
    #メッセージ本文
    @messages = Message.all
    @groupa = Group.find(params[:group_id])
    #サイドバー
    @groups = Group.all
    @user = User.find(current_user.id)
    #メッセージ生成
    @group = Group.where(:id => params[:group_id]).first
    @message = @group.messages.build
  end

  # GET /messages/new
  def new
    @group = Group.where(:id => params[:group_id]).first
    @message = @group.messages.build
    #@message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    
    @message = Message.new(message_params)
    @group = Group.where(:id => params[:group_id]).first
    @message = @group.messages.build
    @message.user_id = current_user.id
    @message.body = message_params[:body]
    @message.image = message_params[:image]
    @groupa = Group.find(params[:group_id])

    respond_to do |format|
      if @message.save
        # format.html { redirect_to group_messages_path(params[:group_id]), notice: 'メッセージを送信しました' }
        # format.json { render :show, status: :created, location: @message }

        #ajax TEST
        format.html
        format.json { render 'messages', handlers: 'jbuilder' }
      else
        format.html { redirect_to group_messages_path(params[:group_id]), notice: 'メッセージを入力してください' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  # def update
  #   respond_to do |format|
  #     if @message.update(message_params)
  #       format.html { redirect_to @message, notice: 'Message was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @message }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @message.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body, :image, :group_id)
    end

    #自分の所属しているグループ以外には入れない
    def ensure_correct_user
      if Member.where(user_id: current_user.id ,group_id: params[:group_id]).length == 0
        flash[:notice] = "かーえーれー"
        redirect_to root_path
      end
    end
end
