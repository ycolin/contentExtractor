#!/user/bin/ruby
#Created at 07-24-2011
#Author: Yannig Colin for Shopeo
#Licenced under MIT licence

require 'rubygems'
require 'nokogiri'
require 'yaml'

unless ARGV.length == 1
  puts "Dude, not the right number of arguments."
  puts "Usage: ruby contentExtractor.rb htmlFileName\n"
  exit
end

PAGE 		= ARGV[0]

_infos 		= YAML.load_file('input.yml')
_doc 		= Nokogiri::HTML(open(PAGE))
_extracted 	= {}

_infos.each do | info |
	
	extract = ""
	xpath = "//"
	xpath += info['xpath']
	
	_doc.xpath(xpath).each do | content |
		
		if (info['extract'] != "text")
			extract += content[info['extract']]
		else
			extract += content.text
		end
		extract += ","
	end
	
	_extracted.store(info['key'], extract)
	
end

puts ""

_extracted.each { |key, value| 
	puts "#{key} is #{value}" 
	puts ""
}
