def initialize(*args)
  super
  @action = :add
end
actions :create_if_missing, :remove
attribute :name, :kind_of => String, :name_atttribute => true
