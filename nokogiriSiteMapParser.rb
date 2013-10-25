require 'nokogiri'
require 'open-uri'
require 'mysql2'
# loads nokogiriSiteMapParser2 ruby file
require_relative 'nokogiriSiteMapParser2'
# creates an object d under the class SiteMapParser and passes the link
d = SiteMapParser.new('http://www.qburst.com/sitemap.xml')
d.configure_database
d.fetch_remote_data
d.parse_data