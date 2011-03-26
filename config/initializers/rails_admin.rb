RailsAdmin.authenticate_with {}
RailsAdmin.config {|c| c.label_methods << :common_name}
#RailsAdmin.config do |config|
#  config.model Species do
#    edit do
#      field :size, :float
#    end
#  end
#end