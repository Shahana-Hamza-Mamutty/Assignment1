class LogParser
=begin
	input : take_src
	output : @src
	initializes the class when it is called 
=end 	
	def initialize(take_src)
		@src = take_src
	end
=begin
	input : @src
	output : h
	opens the file and finds the number of requests at each time 
=end 	
	def parsing
		h = Hash.new(0)
		$d = /\d{1,2}\/[A-Z][a-z][a-z]\/\d{4}\:\d{1,2}/
		File.open(@src) do |file|
			file.each do |line|
				y = $d.match(line)
				if y
					z = y[0]
					h[z] += 1
				end
			end
		end
		puts h
	end
=begin
	input : @src
	output : $f
	finds the highest running time
=end 
	def highest
		arr = Array.new
		$x = /\d+$/
		File.open(@src) do |file|
			file.each do |line|
				 b = $x.match(line)
				 if b
				 arr<<b[0].to_i
				end
			end
		end
		arr = arr.sort
		ele = arr.length-1
		$f = arr[ele]
		link
	end
=begin
	input : @src
	output : g[0] and $f
	prints the slowest url by hour and its running time
=end 	
	def link
		File.open(@src) do |file|
			file.each do |line|
				b = /#{$f}$/
				if b.match(line)
					 v = /http?:\/\/[\S]+/
					 g = v.match(line)
					 puts "the slowest url by hour is #{g[0]} and time is #{$f}"
				end
			end
		end
	end
end
# creates an object m under the class LogParser and passes the src
m = LogParser.new("./a")
m.parsing
m.highest