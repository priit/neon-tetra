class HomeController < ActionController::Base
  def index
    @species = Species.all(:limit => 9)
    @families = Family.all(:order => 'common_name')
  end
end
