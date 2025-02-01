# frozen_string_literal: true

return unless Rails.env.development?

module Rspec
  module Generators
    require 'generators/rspec'

    class ServiceGenerator < Base
      source_root File.expand_path('templates', __dir__)
      class_option :service_specs, type: :boolean, default: true
      class_option :scope, type: :string, default: nil

      def generate_service_spec
        return unless options[:service_specs]

        spec_path = ['spec/services', options[:scope], class_path, "#{file_name}_service_spec.rb"].compact
        template 'service_spec.rb', File.join(spec_path)
      end
    end
  end
end
