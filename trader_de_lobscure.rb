require 'rubygems'
require 'nokogiri'
require 'open-uri'


def trading(pages)
    tab_url = []#on met sa dans un tableau vide
    tab_name = []
    hash_url = Hash.new #on crée un hash

    pages.css('[@class="price"]').each do |node|
      tab_url << node.text
    end
    pages.css('a.currency-name-container.link-secondary').each do |node|
        tab_name << node.text

    end
    i= 0
    while i < tab_url.size
        hash_url.store(tab_name[i], tab_url[i])
        i += 1
    end
    puts hash_url
end
def perform
    return trading(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")))
end
perform
