class Link
  WATIR_FIND_BY = [:class, :html, :id, :index, :name, :text, :xpath]
  SELENIUM_FIND_BY = [:class, :id, :link, :link_text, :name, :xpath]
  
  WATIR_FIND_BY_MAPPING = {
    :link => :text,
    :link_text => :text
  }
  
  SELENIUM_FIND_BY_MAPPING = {
    :text => :link_text
  }
  
  def self.watir_identifier_for identifier
    identifier_for identifier, WATIR_FIND_BY, WATIR_FIND_BY_MAPPING
  end
  
  def self.selenium_identifier_for identifier
    identifier = identifier_for identifier, SELENIUM_FIND_BY, SELENIUM_FIND_BY_MAPPING
    return identifier.keys.first, identifier.values.first
  end
    
  def self.identifier_for identifier, find_by, find_by_mapping
    how, what = identifier.keys.first, identifier.values.first
    return how => what if find_by.include? how
    return find_by_mapping[how] => what if find_by_mapping[how]
    return nil => what
  end
end