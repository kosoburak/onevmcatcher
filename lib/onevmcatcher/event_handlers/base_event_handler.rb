module Onevmcatcher::EventHandlers
  # Basic handler implementing required methods. Can be used
  # as a dummy for testing purposes.
  class BaseEventHandler

    TEMPFILE_BASE = 'vmcatcher_event_metadata_archive'
    EVENT_FILE_REGEXP = /^(?<type>[[:alnum:]]+)_(?<dc_identifier>[[[:alnum:]]-]+)_(?<time>\d+)\.json$/

    attr_reader :vmcatcher_configuration, :options

    # Event handler constructor.
    #
    # @param vmcatcher_configuration [Onevmcatcher::VmcatcherConfiguration] current vmcatcher configuration
    # @param options [Settingslogic] current onevmcatcher configuration
    def initialize(vmcatcher_configuration, options)
      fail(
        ArgumentError,
        '\'vmcatcher_configuration\' must be an instance of Onevmcatcher::VmcatcherConfiguration!'
      ) unless vmcatcher_configuration.kind_of? Onevmcatcher::VmcatcherConfiguration

      @vmcatcher_configuration = vmcatcher_configuration
      @options = options
    end

    # Triggers an archiving procedure on the registered event.
    #
    # @param vmcatcher_event [Onevmcatcher::VmcatcherEvent] event being archived
    def archive!(vmcatcher_event)
      fail(
        ArgumentError,
        '\'vmcatcher_event\' must be an instance of Onevmcatcher::VmcatcherEvent!'
      ) unless vmcatcher_event.kind_of? Onevmcatcher::VmcatcherEvent

      Onevmcatcher::Log.info "[#{self.class.name}] Saving " \
                             "#{vmcatcher_event.type.inspect} " \
                             "for #{vmcatcher_event.dc_identifier.inspect}"

      temp_file = ::Tempfile.new(TEMPFILE_BASE)
      permanent_file_path = ::File.join(
        options.metadata_dir,
        "#{vmcatcher_event.type || 'Unknown'}_#{vmcatcher_event.dc_identifier || 'NoID'}_#{::Time.now.to_i}.json"
      )

      temp_file.write(vmcatcher_event.to_pretty_json)
      temp_file.flush

      ::FileUtils.cp(temp_file.path, permanent_file_path)
      temp_file.close

      true
    end

    # Triggers a handling procedure on the registered event.
    #
    # @param vmcatcher_event [Onevmcatcher::VmcatcherEvent] event being handled
    def handle!(vmcatcher_event)
      fail(
        ArgumentError,
        '\'vmcatcher_event\' must be an instance of Onevmcatcher::VmcatcherEvent!'
      ) unless vmcatcher_event.kind_of? Onevmcatcher::VmcatcherEvent

      Onevmcatcher::Log.warn "[#{self.class.name}] Processing event " \
                             "#{vmcatcher_event.type.inspect} for " \
                             "#{vmcatcher_event.dc_identifier.inspect}"
    end

  end
end
