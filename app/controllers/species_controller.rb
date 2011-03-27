class SpeciesController < ApplicationController
  def index
    if params[:search]
      src = "%#{params[:search]}%"
      @species = Species.where((:common_name =~ src) | 
                               (:latin_name =~ src) | 
                               (:description =~ src))

    elsif params[:family_id]
      @species = Species.where(:family_id => params[:family_id])
    end

    respond_to do |format|
      format.json { render :json => @species.to_json(
        :methods => [:photo_thumb, :photo_small, :photo_medium, :photo_huge]
      )}
    end
  end
end
