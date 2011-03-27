class AquariumsController < ApplicationController
  def show
    @aquarium = Aquarium.find_by_id(session[:aquarium_id], :include => :species)
    respond_to do |format|
      format.json { render :json => @aquarium ? @aquarium.to_json(:methods => [:species, :status]) : {'error' => 'true'} }
    end
  end

  def create
    @aquarium = Aquarium.new(params[:aquarium])
    @aquarium.volume = 90 if @aquarium.volume.to_i < 1 

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
      text.merge!(feedback_sentence('added to'))
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
      sp = Spcecies.find_by_id(params[:id].to_i)
      @aquarium.remove(params[:id], params[:count])
      text = @aquarium.status
      text.merge!(feedback_sentence('removed from'))
    else
      text = {'error' => 'true'}
    end
    respond_to do |format|
      format.json { render :text => text.to_json }
    end
  end
  
  private
  
  def feedback_sentence(action)
    sp = Species.find_by_id(params[:id])
    if sp
      amount = params[:amount].to_i > 0 ? params[:amount].to_i : 1
      return {'message' => "#{amount} #{amount > 1 ? sp.common_name.pluralize : sp.common_name} successfully #{action} your tank"}
    end
    {'message' => ''}
  end
end
