# frozen_string_literal: true

module Serverspec::Type
  class DockerNode < DockerBase
    def active?
      availability == 'active'
    end

    def draining?
      availability == 'drain'
    end

    def paused?
      availability == 'pause'
    end

    def availability
      inspection['Spec']['Availability']
    end

    def role
      inspection['Spec']['Role']
    end

    def manager?
      role == 'manager'
    end

    def worker?
      role == 'worker'
    end

    def labels
      inspection['Spec']['Labels']
    end

    def has_engine_version?(version)
      engine_version == version
    end

    def engine_version
      inspection['Description']['Engine']['EngineVersion']
    end

    def exist?
      get_inspection.success?
    end

    private

    # rubocop:disable Naming/AccessorMethodName
    def get_inspection
      @get_inspection ||= @runner.run_command("docker node inspect #{@name}")
    end
    # rubocop:enable Naming/AccessorMethodName
  end
end
