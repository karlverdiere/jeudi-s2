require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(page)
    #get 1 email adress from a particular web page => i found the path by right click inside the inspector, and copy , xpath
    page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |email|
        puts email.text
      end
end

#get all emails from all URL of the val-d'oise page
def get_all_the_urls_of_val_doise_townhalls(pages)
    tab_url = []#on met sa dans un tableau vide
    tab_name = []
    hash_url = Hash.new #on crée un hash
    #------------------------------------------------------------------------------------------------
    #this loop store one by one, each href object containing /95/ after been(rebuilt like a puzzle) :
    #converted in string with .to_s
    #modificated with .gsub("", "")
    #wich is a method for replacing the first element put in first argument, by the second one
    pages.css('//@href').grep(/95/).each do |node|
        tab_url << node.to_s.gsub("./", "http://annuaire-des-mairies.com/")
    end
    pages.css('a.lientxt').each do |node|
        tab_name << node.text
    end
  # this loop store both tab name and url properly in a wonderful hash_tab :
    i= 0
    while i < tab_url.size
        hash_url.store(tab_name[i], tab_url[i])
        i += 1
    end
    #this loop go through the URL tab and call the email function above with each URL put as opens argument
    tab_url.each do |url|
        get_the_email_of_a_townhal_from_its_webpage(Nokogiri::HTML(open(url)))
    end
end
def perform
    return get_all_the_urls_of_val_doise_townhalls(Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html")))
end
perform
