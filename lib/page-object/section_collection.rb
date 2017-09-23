module PageObject
  class SectionCollection < Array

    %i:select reject drop_while take_while reverse:.each {|method| define_method(method) {|*args,&block| self.class[*super(*args,&block).to_a]}}

    def find_by(values_hash)
      find do |section|
        values_hash.all? { |key, value| value === section.public_send(key) }
      end
    end

    def select_by(values_hash)
      matches = select do |section|
        values_hash.all? { |key, value| value === section.public_send(key) }
      end
      self.class[*matches.to_a]
    end

    def first *n
      res = super
      n.empty? ? res : self.class[*res.to_a]
    end

    def last *n
      res = super
      n.empty? ? res : self.class[*res.to_a]
    end
  end
end
