begin
  require 'bunny'
rescue LoadError
  $stderr.puts "Missing bunny gem. Please run 'bundle install'."
  exit 1
end
