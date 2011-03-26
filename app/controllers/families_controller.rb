class FamiliesController < ApplicationController
  def index
    @families = Species.commen_name_or_latin_name_or_description((params[:species])

    respond_to do |format|
      format.json { render :json => @families.to_json }
    end
  end
end
