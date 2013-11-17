#  server.rb

require 'socket'
require 'thread'

pw = 'password' #~ please adjust this

tmp = ''
mind = {}
mx_mind = Mutex.new
server = TCPServer.new 31111

loop do
	Thread.start(server.accept) do |client|
		l = client.readline

		if l[0] == 'R'
			mx_mind.synchronize {
				tmp = mind[l[1..-1].strip]
			}

			client.write tmp
		elsif l.strip == 'W'+pw
			r = client.gets.strip
			mx_mind.synchronize {
				mind[r] = ''

				while line = client.read(10*1024*1024)
					mind[r] += line
				end
			}
		end

		client.close
	end
end
