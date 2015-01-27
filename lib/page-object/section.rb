module PageObject
  class Section < Elements::Element
    extend Accessors
    attr_reader :platform
    #Given that page sections implement their own behaviors,
    #we don't want misses to fall through to the watir element
    undef_method :method_missing

    private
    #there is currently no better way to handle the dual nature of sections being like elements and pages
    def call_block(&block)
      block.arity == 1 ? block.call(self) : self.instance_eval(&block)
    end
  end
  class SectionCollection
    include Enumerable
    attr_reader :sections

    def initialize sections
      @sections = sections
    end

    def each &block
      sections.each(&block)
    end

    def find_by values_hash
      find { |section| values_hash.all? { |method, matcher| matcher === section.send(method) } }
    end

    def select_by values_hash
      sections = select { |section| values_hash.all? { |method, matcher| matcher === section.send(method) } }
      SectionCollection.new(sections)
    end
  end
end
