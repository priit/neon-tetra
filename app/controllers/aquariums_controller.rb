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
      format.json { render :json => @aquarium ? @aquarium.status : {'error' => 'true'} }
    end
  end

  # TODO move this logic into separate controller
  def add
    @aquarium = Aquarium.find_by_id(session[:aquarium_id])
    if @aquarium && !params[:id].blank?
      @aquarium.add(params[:id], params[:count].to_i)
      text = @aquarium.status
    else
      text = {'error' => 'true'}
    end
    respond_to do |format|
      format.json { render :text => text.to_json }
    end
  end
  
  def remove
    @aquarium = Aquarium.find_by_id(session[:aquarium_id])
    if @aquarium && !params[:id].blank?
      @aquarium.remove(params[:id], params[:count])
      text = @aquarium.status
    else
      text = {'error' => 'true'}
    end
    respond_to do |format|
      format.json { render :text => text.to_json }
    end
  end
end
