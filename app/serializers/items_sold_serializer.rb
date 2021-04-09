class ItemsSoldSerializer
  include FastJsonapi::ObjectSerializer
  attributes :count, :name

end
