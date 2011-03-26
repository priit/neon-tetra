class FamiliesController < ApplicationController
  def index
    src = "%#{params[:search]}%"
    @families = Species.where((:common_name =~ src) | (:latin_name =~ src))
    #@families = Species.commen_name_or_latin_name_or_description((params[:species])

    respond_to do |format|
      format.json { render :json => @families.to_json }
    end
  end
end
