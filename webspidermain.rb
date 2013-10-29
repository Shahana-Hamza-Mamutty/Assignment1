require 'nokogiri'
require 'open-uri'
require 'mysql2'
# loads webspider ruby file
require_relative 'webspider'
# creates an object d under the class WebSpider and passes the link
d = WebSpider.new("http://www.1mobile.com/downloads/")
d.configure_database
d.categories
