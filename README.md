assocserver
===========

A simple, parallel TCP server for storing associative arrays in RAM only, written in Ruby.

This program listens on TCP port 31111. You can store and retrieve strings with
it. To start the server, use

	ruby server.rb

If you start the program for the first time, please adjust the password in server.rb.
This password is necessary to store contents and it should be kept secret.

Note that everything is saved to pure memory, no strings attached. If you terminate
assocserver, all contents will be lost. However, it is very easy to extend assocserver
in such a manner that contents are saved to a permanent file system and retrieved later
on.

Network Protocol
----------------

Individual contents are retrieved using a descriptor. If you want to store some string
in the descriptor **test**, your program has to send the following to TCP port 31111:

	W[password]
	test
	[Your contents here]

The lines are followed by newline characters. Replace the things in the brackets []
accordingly. If you want to retrieve the contents from the descriptor **test**, you have to
send the following, followed by a newline character:

	Rtest

The server will instantly send you the contents after a lock has been acquired. If **test** does not
yet exist, the server will close the connection instantly.
