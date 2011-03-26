RailsAdmin.authenticate_with {}
RailsAdmin.config do |config| 
  config.label_methods << :common_name

  config.model Species do
    field :common_name
    field :latin_name
    field :description

    field :family_id
    field :tank_size
    field :size do
      label 'Size (cm)'
    end
    field :size_descriptor
    field :agressivness
    field :activity
    field :plant_eater
    field :min_group_size
    field :min_temperature
    field :max_temperature
    field :min_ph
    field :max_ph
    field :min_dh
    field :max_dh
    field :tag_list
    field :photo
  end
end
