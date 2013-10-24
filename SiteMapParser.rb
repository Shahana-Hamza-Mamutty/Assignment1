class SiteMapParser
	def initialize(take_link)
 		@map_link = take_link
 		@data = ""
 	end
 	def configure_database
 		@client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "shahana7", :database => "url")
 	end
	def fetch_remote_data
    	Net::HTTP.start( @map_link, 80 ) do |http|
    	@data = ( http.get( '/sitemap.xml' ).body )
    	end
	end	
	def parse_data
		while @data.include? "<loc>"
			open = @data.index("<loc>")
			close = @data.index("</loc>",open)
			value = @data[open+5..close-1]
			begin
				insert = @client.query("INSERT INTO link (links) VALUES ('#{value}')")
			rescue Exception=>e
				puts e.message
			end
			@data[open..close] = '' if close
		end
		@client.close
	end
end