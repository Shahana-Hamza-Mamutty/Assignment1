=begin
	configures the database
	fetches the remote data
	parses the data and inserts them in to database 
=end
class SiteMapParser
=begin
	input : take_link
	output : @map_link
	initializes the class when it is called 
=end 	
  def initialize(take_link)
 	 	@map_link = take_link
 	end
=begin
	input : nil
	output : @client
	establishes connection with the database
=end
 	def configure_database
 		@client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "shahana7", :database => "url")
 	end
=begin
	input : @map_link
	output : @data
	fetches the xml sitemap link content
=end 	
	def fetch_remote_data
    doc = Nokogiri::XML(open(@map_link))
    @data = doc.remove_namespaces!()
	end	
=begin
	input : @data
	output : node.text
	parses the xml sitemap link and inserts the content in to database
=end	
	def parse_data
		@x = @data.xpath('//url/loc')
		@x.each do |node|
		begin
			insert = @client.query("INSERT INTO link (links) VALUES ('#{ node.text }')")
		
		rescue Exception=>e
			puts e.message
		end
		
		end
		@client.close
	end
end