class WebSpider
=begin
	input : take_link
	output : @link
	initializes the class when it is called 
=end 
	def initialize(take_link)
 	 	@link = take_link
 	end
=begin
	input : nil
	output : @client
	establishes connection with the database
=end 	
 	def configure_database
 		@client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "shahana7", :database => "spiderman")
 	end
=begin
	input : @link
	output : h.text
	inserts categories into database and calls method eachCategory
=end 	
 	def categories
 		doc = Nokogiri::HTML(open(@link))
 		doc.xpath('//div[@class = "c"]//em//a').each do |h|
 			if h.text == "Top Downloads" or h.text == "Top Trends" or h.text == "Top New Games"or h.text == "Top New Apps" or h.text == "Top Games" or h.text == "Top Apps" then
 				next
 			end
 			$cat = h.text
 			
 			insert = @client.query("INSERT INTO categories (names) VALUES ('#{ h.text }')")
 			eachCategory(h['href'])
 		end
 		@client.close
 	end
=begin
	input : spec ie h['href'] passed from method categories
	output : nil
	retrieves name of each category and stores in $ap and calls method categoryDetail
=end  	
 	def eachCategory(spec)
 		@combine = "http://www.1mobile.com" + spec
 		doc = Nokogiri::HTML(open(@combine))
 		 doc.xpath('//div[@class="searchapps"]//ul[@id="searchresult"]//li//p//a').each do |h|
 			aps = h.text
 			$ap = aps.gsub("'","")
 			categoryDetail(h['href'])
 		end
 	end
=begin
	input : val ie h['href'] passed from method eachCategory
	output : $cat, $ap, @desc, k.text
	inserts name of the application, category name, description and their screenshot links into database
=end  	
 	def categoryDetail(val)
 		@join = "http://www.1mobile.com" + val
 		if @join.include? "["
 			open = @join.index("[")
 			close = @join.index("]",open)
 			@join[open..close+1] = ""
 			end
 		doc = Nokogiri::HTML(open(@join))
 		@descrp = doc.xpath('//div[@class="simpleinfo"]').text
 		@desc = @descrp.gsub("'","")
 		
 		insert = @client.query("INSERT INTO applications (name, app_name, description) VALUES ('#{ $cat }','#{ $ap }','#{ @desc }')")
 		doc.xpath('//div[@class="detailslidercnt"]//span//img//@src').each do |k|
 			
 			insert = @client.query("INSERT INTO scree_shots (app_name, screen) VALUES ('#{ $ap }','#{ k.text }')")
 		end
 		sleep(1)
 	end
 end 
