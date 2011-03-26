class HomeController < ActionController::Base
  def index
    @species = Species.all
  end
end
