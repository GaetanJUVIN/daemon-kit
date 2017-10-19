# Generated amqp daemon

# Do your post daemonization configuration here
# At minimum you need just the first line (without the block), or a lot
# of strange things might start happening...
DaemonKit::Application.running! do |config|
  # Trap signals with blocks or procs
  # config.trap( 'INT' ) do
  #   # do something clever
  # end
  # config.trap( 'TERM', Proc.new { puts 'Going down' } )
end

# IMPORTANT CONFIGURATION NOTE
#
# Please review and update 'config/bunny.yml' accordingly or this
# daemon won't work as advertised.

# Run an event-loop for processing
DaemonKit::Bunny.run do |connection|

  channel  = connection.create_channel
  queue    = channel.queue("test")

  queue.subscribe(block: true) do |deliver, properties, package|
    puts package.inspect
  end
end
