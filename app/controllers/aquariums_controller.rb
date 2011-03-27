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
  
  def status
    @aquarium = Aquarium.find_by_id(session[:aquarium_id])
    respond_to do |format|
      format.json { render :json => @aquarium.status }
    end
  end
  
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
