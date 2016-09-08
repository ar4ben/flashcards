# ruby encoding: utf-8
require 'nokogiri'
require 'open-uri'

def create_words(page)
	page.xpath('//tr[contains(@class,"row") and ./td[3]/text()[string-length() > 1]]').each do |word|
		original = word.xpath('./td[@class="bigLetter"]').text
		translated = word.xpath('./td[3]').text
		puts "creating word #{original} - #{translated}"
		Card.create(original_text: original, translated_text: translated)
	end
end

def create_pages_with_words(page)
	base_url = "http://www.languagedaily.com"
	page.xpath('//h3[contains(text(),"Index of most common")]/following-sibling::ul//a[@href]/@href').each do |link|
		puts "downloading page #{base_url}#{link.text}..."
		new_page = Nokogiri::HTML(open("#{base_url}#{link.text}"))
		create_words(new_page)
	end
end

seed_url = Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words-11"))
create_pages_with_words(seed_url)
create_words(seed_url)
