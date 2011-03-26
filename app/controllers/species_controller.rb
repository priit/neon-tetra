class SpeciesController < ApplicationController
  def index
    src = "%#{params[:search]}%"

    @species = Species.where((:common_name =~ src) | 
      (:latin_name =~ src) | (:description =~ src))

    respond_to do |format|
      format.json { render :json => @species.to_json }
    end
  end
end
