class ResourceGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i(index new create)
  before_action :set_resource_group, only: %i(show edit update destroy)
  authorize_resource

  def index
    @resource_groups = @game.resource_groups
  end

  def show; end

  def new
    @resource_group = @game.resource_group.build
    authorize! :new, @resource_group
  end

  def edit; end

  def create
    @resource_group = ResourceGroup.new(resource_group_params)
    @resource.game = @game
    authorize! :create, @resource

    if @resource_group.save
      redirect_to resource_group_url(@resource_group), notice: "Group created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @resource_group.update(resource_group_params)
      redirect_to resource_group_url(@resource_group), notice: "Group updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    game = @resource_group.game
    @resource_group.destroy

    redirect_to game_resource_groups_url(game), notice: "Group deleted"
  end
end
