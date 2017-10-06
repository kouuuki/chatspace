class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit]
  before_action :authenticate_user!

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    @user = User.find(current_user.id)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @member = Group.includes(:users)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to root_path, notice: 'グループを作成しました' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_messages_path(params[:id]), notice: 'グループ情報を更新しました' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%")
    render json: @users
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, {:user_ids => []})
    end

    #自分の所属しているグループ以外は編集できない
    def ensure_correct_user
      if Member.where(user_id: current_user.id ,group_id: params[:id]).length == 0
        flash[:notice] = "かーえーれー"
        redirect_to root_path
      end
    end
end
