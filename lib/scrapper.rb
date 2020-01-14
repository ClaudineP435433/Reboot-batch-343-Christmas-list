require 'open-uri'
require 'nokogiri'

def scrapper(article)
  suggestion = []
  url = "https://www.etsy.com/fr/search?q=#{article}"

  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.v2-listing-card__info').first(5).each do |element|
    name = element.search('h2').text.strip
    price = element.search(".currency-value").text.strip.to_f
    new_gift = {name: name, price: price, bought: false}
    suggestion << new_gift
  end
  return suggestion
end
