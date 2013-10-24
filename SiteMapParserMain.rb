require 'net/http'
require 'mysql2'
require_relative 'SiteMapParser'
d = SiteMapParser.new('www.qburst.com')
d.configure_database
d.fetch_remote_data
d.parse_data