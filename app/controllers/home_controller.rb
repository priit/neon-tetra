class HomeController < ActionController::Base
  def index
    @species = Species.all
    @families = Family.all(:order => 'common_name')
  end
end
