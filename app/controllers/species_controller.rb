class SpeciesController < ApplicationController
  def index
    src = "%#{params[:search]}%"

    @species = Species.where((:common_name =~ src) | 
      (:latin_name =~ src) | (:description =~ src))

    respond_to do |format|
      format.json { render :json => @species.to_json(
        :methods => [:photo_thumb, :photo_small, :photo_medium, :photo_huge]
      )}
    end
  end
end
