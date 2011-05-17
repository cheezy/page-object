
module Element
  def self.included(cls)
    cls.extend ClassMethods
  end

  module ClassMethods
    def identifier_for identifier, find_by, find_by_mapping
      how, what = identifier.keys.first, identifier.values.first
      return how => what if find_by.include? how
      return find_by_mapping[how] => what if find_by_mapping[how]
      return nil => what
    end
  end
end