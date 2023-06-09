class FacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_die, only: %i(index new create)
  before_action :set_face, only: %i(edit update destroy)
  authorize_resource

  # GET /faces or /faces.json
  def index
    @faces = @die.faces
  end

  # GET /faces/new
  def new
    authorize! :manage, @die
    @face = @die.faces.build
  end

  # GET /faces/1/edit
  def edit; end

  # POST /faces or /faces.json
  def create
    authorize! :manage, @die
    @face = Face.new(face_params)
    @face.die = @die

    respond_to do |format|
      if @face.save
        format.html { redirect_to die_faces_url(@die), notice: "Face was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /faces/1 or /faces/1.json
  def update
    respond_to do |format|
      if @face.update(face_params)
        format.html { redirect_to die_faces_url(@face.die), notice: "Face was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faces/1 or /faces/1.json
  def destroy
    die = @face.die
    @face.destroy

    respond_to do |format|
      format.html { redirect_to die_faces_url(die), notice: "Face was successfully destroyed." }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_face
    @face = Face.find(params[:id])
  end

  def set_die
    @die = Die.find(params[:die_id])
  end

  # Only allow a list of trusted parameters through.
  def face_params
    params.require(:face).permit(:die_id, :name, :count)
  end
end
