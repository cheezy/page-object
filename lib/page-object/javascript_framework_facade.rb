require 'page-object/javascript/jquery'
require 'page-object/javascript/prototype'

module PageObject
  module JavascriptFrameworkFacade

    class << self
      def framework=(framework)
        @framework = framework
      end

      def framework
        @framework
      end

      def script_builder
        initialize_script_builder unless @builder
        @builder[@framework]
      end

      def pending_requests
        script_builder.pending_requests
      end

      private

      def initialize_script_builder
        @builder = {
          :jquery => ::PageObject::Javascript::JQuery,
          :prototype => ::PageObject::Javascript::Prototype
        }
      end
    end
  end
end
