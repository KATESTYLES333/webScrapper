require 'open-uri'
require 'nokogiri'
require 'csv'
require 'xpath'
require 'curb'

url = 'https://www.petsonic.com/snacks-huesos-para-perros/'
# html = open(url)

html = Curl.get('http://www.google.com/')
puts html.body_str

doc = Nokogiri::HTML(html)
products = []

product_names = doc.xpath("//a[@class='product-name']/@title")
images = doc.xpath("//img[@width='250']/@src")
prices = doc.xpath("//span[@class='price product-price']")

(0..product_names.length - 1).each do |i|
  products.push(
    productName: product_names[i],
    price: prices[i].to_s.scan(/[0-9]+/).join('.'),
    image: images[i]
  )
end

CSV.open('D:/MyFirstrep/Ruby/webScraper/file1.csv', 'wb') do |csv|
  products.each do |i|
    csv << ["#{i[:productName]}; #{i[:price]}; #{i[:image]}"]
  end
end
