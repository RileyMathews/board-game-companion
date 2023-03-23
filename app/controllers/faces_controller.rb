class FacesController < ApplicationController
  let(:die) { Die.find params[:die_id] }
  let(:faces) { die.faces }
  let(:face) { Face.find_or_initialize_by id: params[:id] }

  def show; end

  def new; end

  def edit; end

  def create
    face.die = die
    save
  end

  def update
    save
  end

  def destroy
    face.destroy

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Face was successfully destroyed." }
    end
  end

  private

  def save
    respond_to do |format|
      if face.update(secure_params)
        format.turbo_stream { flash.now[:notice] = "Face was successfully saved." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def secure_params
    params.require(:face).permit(:name, :count)
  end
end
