class Button
  include Element

  WATIR_FIND_BY = [:class, :id, :index, :name, :xpath]
  SELENIUM_FIND_BY = [:class, :id, :name, :xpath]

  WATIR_FIND_BY_MAPPING = {
  }

  SELENIUM_FIND_BY_MAPPING = {
  }

  def self.watir_identifier_for identifier
    identifier_for identifier, WATIR_FIND_BY, WATIR_FIND_BY_MAPPING
  end

end