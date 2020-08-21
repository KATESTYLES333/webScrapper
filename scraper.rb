require 'open-uri'
require 'nokogiri'
require 'csv'
require 'xpath'
require 'curb'

url = 'https://www.petsonic.com/snacks-huesos-para-perros/'
#html = open(url)

html = Curl.get("http://www.google.com/")
puts html.body_str

doc = Nokogiri::HTML(html)
products = []

productNames = doc.xpath("//a[@class='product-name']/@title")
images = doc.xpath("//img[@width='250']/@src")
prices = doc.xpath("//span[@class='price product-price']")

for i in 0..productNames.length()-1 do
    products.push(
        productName: productNames[i],
        price: prices[i].to_s.scan(/[0-9]+/).join('.'),
        image: images[i]
      )
end

CSV.open("D:/MyFirstrep/Ruby/webScraper/file1.csv", "wb") do |csv|
     for i in products
        csv<< ["#{i[:productName]}; #{i[:price]}; #{i[:image]}"]
     end  
end