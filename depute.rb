
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def depute_email(name, email)

    hash = Hash.new
    # this loop store both tab name and url properly in a wonderful hash_tab :
    i= 0
    while i < name.size
        hash.store(name[i], email[i])
        i += 1
    end
    return hash
end
#--------------------------------------------------------------------------------------
def get_name(page)
    @name = []
    #deputes-list
    page.css('//div/div/ul/li/a').grep(/M/).each do |node|
        @name << node.text
    end
    return @name
end
def get_url(page)
    @url = []
    page.css('//@href').grep(/OMC_PA/).each do |node|
        @url << node.to_s.gsub("/deputes/", "http://www2.assemblee-nationale.fr/deputes/")
    end
    return @url
end

def get_email(url)
    @email = []
    url.each do |page|
        page = Nokogiri::HTML(open(page))
        page.css('//@href').grep(/mailto/).each do |node|
            puts node.to_s.gsub("mailto:", "")
            @email << node.to_s.gsub("mailto:", "")
        end
    end
    puts @email
    return @email
end

def perform(page_web)
    hash = depute_email(get_name(page_web), get_email(get_url(page_web)))
    return hash

end

print perform(Nokogiri::HTML(open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique')))
