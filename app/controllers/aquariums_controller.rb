class AquariumsController < ApplicationController
  def show
    @aquarium = Aquarium.find(params[:id], :include => :species)

    respond_to do |format|
      format.json { render :json => @aquarium.to_json(:methods => [:species, :status]) }
    end
  end

  def create
    @aquarium = Aquarium.new(params[:aquarium])

    respond_to do |format|
      if @aquarium.save
        session[:aquarium_id] = @aquarium.id
        format.json { render :json => @aquarium }
      end
    end
  end
  
  def status
    @aquarium = Aquarium.find_by_id(session[:aquarium_id])
    respond_to do |format|
      format.json { render :json => @aquarium.status }
    end
  end

  # TODO move this logic into separate controller
  def add
    @aquarium = Aquarium.find_by_id(session[:aquarium_id])
    if @aquarium && !params[:id].blank?
      @aquarium.add(params[:id], params[:count])
      respond_to do |format|
        format.json { render :json => @aquarium.status }
      end
    end
  end
  
  def remove
    @aquarium = Aquarium.find_by_id(session[:aquarium_id])
    if @aquarium && !params[:id].blank?
      @aquarium.remove(params[:id], params[:count])
      respond_to do |format|
        format.json { render :json => @aquarium.status }
      end
    end
  end
end
