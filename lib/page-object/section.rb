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
end
