module PageObject
  class SectionCollection < Array
    def find_by(values_hash)
      find do |section|
        values_hash.all? { |key, value| value === section.public_send(key) }
      end
    end

    def select_by(values_hash)
      matches = select do |section|
        values_hash.all? { |key, value| value === section.public_send(key) }
      end
      self.class[*matches]
    end
  end
end
