actions :create, :remove

default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :programs, :kind_of => Array, :required => true, 
  :callbacks => {
    "At least one program is required" => lambda { |x| x.empty? }
  }
