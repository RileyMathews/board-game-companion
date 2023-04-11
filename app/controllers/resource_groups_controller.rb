class ResourceGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i(index new create)
  before_action :set_resource_group, only: %i(edit update destroy)
  authorize_resource

  def index
    @resource_groups = @game.resource_groups
  end

  def new
    @resource_group = @game.resource_groups.build
    authorize! :new, @resource_group
  end

  def edit; end

  def create
    @resource_group = ResourceGroup.new(resource_group_params)
    @resource_group.game = @game
    authorize! :create, @resource_group

    if @resource_group.save
      redirect_to game_resource_groups_url(@game), notice: "Group created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @resource_group.update(resource_group_params)
      redirect_to game_resource_groups_url(@resource_group.game), notice: "Group updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    game = @resource_group.game
    @resource_group.destroy

    redirect_to game_resource_groups_url(game), notice: "Group deleted"
  end

private

  def set_game
    @game = Game.find params[:game_id]
  end

  def set_resource_group
    @resource_group = ResourceGroup.find params[:id]
  end

  def resource_group_params
    params.require(:resource_group).permit(:name)
  end
end
