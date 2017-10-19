require 'yaml'
require 'bunny'

module DaemonKit
  # Thin wrapper around the bunny gem, specifically designed to ease
  # configuration of a Bunny consumer daemon and provide some added
  # simplicity
  class Bunny

    @@instance = nil

    class << self
      def instance
        @instance ||= new
      end

      private :new

      def run(&block)
        instance.run(&block)
      end

      def start
        instance.start
      end
    end

    def initialize( config = {} )
      @config = DaemonKit::Config.load('bunny').to_h( true )
    end

    def run(&block)
      # Start our event loop and Bunny client
      ::Bunny.run(@config) do |connection|
        # Ensure graceful shutdown of the connection to the broker
        hook = Proc.new { connection.close { EventMachine.stop } }
        DaemonKit.trap('INT', hook)
        DaemonKit.trap('TERM', hook)

        yield connection
      end
    end

    def start(&block)
      # Start the bunny client with the config
      ::Bunny.new(@config)
    end
  end
end
