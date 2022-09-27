require 'dd_wrapper/version'
require 'dd_wrapper/railtie' if defined?(Rails)
require 'aws-sdk' if defined?(Aws)
require 'ddtrace'

module DdWrapper
  class Error < StandardError; end

  DEFAULT_INSTRUMENTS = {
    faraday: {},
    rails: {},
    rake: {},
    pg: {},
  }

  def self.setup(instruments = {})
    if ENV['DATADOG_ENABLED'].present? && defined?(Datadog).present?
      Datadog.configure do |c|
        c.service = Rails.application.class.parent_name.underscore
        c.env = Rails.env || 'production'
        # Enables instrumentation
        c.tracing.report_hostname = true
        DEFAULT_INSTRUMENTS.each do |inst, val|
          next unless gem_installed?(inst.to_s)

          c.tracing.instrument(inst, val || {})
        end

        instruments.each do |inst, val|
          next unless gem_installed?(inst.to_s)

          c.tracing.instrument(inst, val)
        end
        c.tracing.sampling.default_rate = 1.0

        # Enable APM
        c.profiling.enabled = true
      end
    end    
  end

  def self.gem_installed?(instrument)
    Gem::Dependency.new(get_gem_name(instrument)).matching_specs.present?
  end

  def self.get_gem_name(name_)
    # Add gem name here that is different has different dd instrument name.
    return 'aws-sdk' if name_ == 'aws'
    name_
  end
end
