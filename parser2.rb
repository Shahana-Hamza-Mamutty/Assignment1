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
    $h = Hash.new(0)
    $regex = /\d{1,2}\/[A-Z][a-z][a-z]\/\d{4}\:\d{1,2}/
    File.open(@src) do |file|
      file.each do |line|
        outpt = $regex.match(line)
        if outpt
	  z = outpt[0]
	  $h[z] += 1
	end
      end
    end
    $h.each do |val1, val2|
      if val2 > 1
        puts  "#{val1}  - have #{val2} requests"
      else
        puts  "#{val1}  - have #{val2} request"
      end
    end
  end
=begin
  input : $h
  output : $arr
  find the highest running time of each request
=end 		
  def ofEach
    $h.each do |val1,val2|
      $arr = Array.new(0)
      File.open(@src) do |file|
        file.each do |line|
          if line.include? val1 
            time = /\d+$/.match(line)
	    if time
	      $arr<<time[0].to_i
	    end
	  end
        end
      end
      link($arr.sort.last)
      puts "\n" 
    end
  end
=begin
  input : @src
  output : arr1
  finds the highest running time
=end 
  def highest
    arr1 = Array.new
    $x = /\d+$/
    File.open(@src) do |file|
      file.each do |line|
        time = $x.match(line)
        if time
	  arr1<<time[0].to_i
	end
      end
    end
    link(arr1.sort.last)
  end
=begin
  input : @src
  output : g[0] and run_tim
  prints the slowest url by hour and its running time
=end 	
  def link(run_tim)
    File.open(@src) do |file|
      file.each do |line|
        if line.include? run_tim.to_s 
	  v = /http?:\/\/[\S]+/
	  url = v.match(line)
	  if url
	    puts "the slowest url by hour is #{url[0]} and time is #{run_tim}"
	    break
	  end
	end
      end
    end
  end
end
# creates an object m under the class LogParser and passes the src
m = LogParser.new("./a")
m.parsing
m.ofEach
m.highest
