class AquariumsController < ApplicationController
  def create
    @aquarium = Aquarium.new(params[:aquarium])

    respond_to do |format|
      if @aquarium.save
        session[:aquarium_id] = @aquarium.id
        format.json { render :json => @aquarium }
      end
    end
  end
end
