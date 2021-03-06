module Alephant
  module Renderer
    module Views
      class << self
        def register(klass)
          views[underscorify(klass.name.split('::').last)] = klass
        end

        def get_registered_class(id)
          views[id.downcase]
        end

        def underscorify(str)
          str.gsub(/::/, '/')
             .gsub(/([A-Z]+)([A-Z][a-z])/, '\\1_\\2')
             .gsub(/([a-z\d])([A-Z])/, '\\1_\\2')
             .tr('-', '_')
             .downcase
        end

        private

        def views
          @views ||= {}
        end
      end
    end
  end
end
