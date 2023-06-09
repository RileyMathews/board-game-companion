class ResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i(index new create)
  before_action :set_resource, only: %i(edit update destroy)
  authorize_resource

  # GET /resources or /resources.json
  def index
    @resources = @game.resources
  end

  # GET /resources/new
  def new
    authorize! :manage, @game
    @resource = @game.resources.build

    @resource_group_options = resource_group_options @game
  end

  # GET /resources/1/edit
  def edit
    @resource_group_options = resource_group_options @resource.game
  end

  # POST /resources or /resources.json
  def create
    authorize! :manage, @game
    @resource = Resource.new(resource_params)
    @resource.game = @game

    respond_to do |format|
      if @resource.save
        format.html { redirect_to game_resources_url(@game), notice: "Resource was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resources/1 or /resources/1.json
  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to game_resources_url(@resource.game), notice: "Resource was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1 or /resources/1.json
  def destroy
    game = @resource.game
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to game_resources_url(game), notice: "Resource was successfully destroyed." }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = Resource.find(params[:id])
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def resource_group_options(game)
    [["------", ""]] + game.resource_groups.map { |group| [group.name, group.id] }
  end

  # Only allow a list of trusted parameters through.
  def resource_params
    params.require(:resource).permit(:game_id, :name, :min, :max, :resource_group_id)
  end
end
