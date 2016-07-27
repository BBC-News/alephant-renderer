require 'alephant/renderer/error/invalid_path'
require 'alephant/logger'

module Alephant
  module Renderer
    class ViewMapper
      include Logger

      DEFAULT_LOCATION = 'components'.freeze

      def initialize(renderer_id, view_base_path = nil)
        self.base_path = "#{view_base_path}/#{renderer_id}" unless view_base_path.nil?
      end

      def base_path
        @base_path || DEFAULT_LOCATION
      end

      def base_path=(path)
        @base_path = File.directory?(path) ? path : raise_error(path)
      end

      def generate(data)
        model_locations.reduce({}) do |obj, file|
          model_id      = model_id_for(file)
          obj[model_id] = model(model_id, data)
          obj
        end
      end

      private

      def raise_error(path)
        logger.metric('ViewMapperInvalidPath')
        logger.error(
          event:  :ViewMapperBasePathInvalidFound,
          path:   path,
          method: "#{self.class}#raise_error"
        )
        raise(Error::InvalidBasePath.new(path))
      end

      def model(view_id, data)
        require model_location_for view_id
        Views.get_registered_class(view_id).new(data)
      end

      def model_location_for(view_id)
        File.join(base_path, 'models', "#{view_id}.rb")
      end

      def model_locations
        Dir[model_base_path]
      end

      def model_base_path
        "#{base_path}/models/*"
      end

      def model_id_for(location)
        location.split('/').last.sub(/\.rb/, '')
      end
    end
  end
end
