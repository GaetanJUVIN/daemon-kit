require "daemon_kit/version"

# Seems we need to load openssl before em or there are failures all around.
# But we need to consider that people might not have ssl in the first place.
begin
  require 'openssl'
rescue LoadError
end
require 'eventmachine'

require File.dirname(__FILE__) + '/daemon_kit/core_ext'
require File.dirname(__FILE__) + '/daemon_kit/exceptions'

$LOAD_PATH.unshift( File.dirname(__FILE__).to_absolute_path ) unless
  $LOAD_PATH.include?( File.dirname(__FILE__).to_absolute_path )

module DaemonKit

  autoload :Initializer,    'daemon_kit/initializer'
  autoload :Application,    'daemon_kit/application'
  autoload :Arguments,      'daemon_kit/arguments'
  autoload :Config,         'daemon_kit/config'
  autoload :PidFile,        'daemon_kit/pid_file'
  autoload :AbstractLogger, 'daemon_kit/abstract_logger'
  autoload :EM,             'daemon_kit/em'
  autoload :Configurable,   'daemon_kit/core_ext/configurable'
  autoload :Generators,     'daemon_kit/generators'

  autoload :Cron,                   'daemon_kit/cron'
  autoload :Jabber,                 'daemon_kit/jabber'
  autoload :Bunny,                  'daemon_kit/dk_bunny'
  autoload :SQS,                    'daemon_kit/dk_sqs'
  autoload :RuoteParticipants,      'daemon_kit/ruote_participants'
  autoload :RuoteWorkitem,          'daemon_kit/ruote_workitem'
  autoload :RuotePseudoParticipant, 'daemon_kit/ruote_pseudo_participant'
  autoload :XMPP,                   'daemon_kit/xmpp'

  class << self

    def logger
      @logger
    end

    def logger=( logger )
      @logger = logger
    end

    def root
      DAEMON_ROOT
    end

    def env
      DAEMON_ENV
    end

    def production?
      DAEMON_ENV == "production"
    end

    def development?
      DAEMON_ENV == "development"
    end

    def test?
      DAEMON_ENV == "test"
    end

    def framework_root
      @framework_root ||= File.join( File.dirname(__FILE__), '..' ).to_absolute_path
    end
  end
end
