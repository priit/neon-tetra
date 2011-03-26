RailsAdmin.authenticate_with {}
RailsAdmin.config do |config| 
  config.label_methods << :common_name

  config.model Species do
    field :common_name
    field :latin_name
    field :description

    field :family_id
    field :tank_size
    field :size
    field :size_descriptor
    field :agressivness
    field :activity
    field :shield
    field :endurance
    field :plant_eater
    field :min_group_size
    field :min_temperature
    field :max_temperature
    field :min_ph
    field :max_ph
    field :tag_list
    field :photo
  end
end
