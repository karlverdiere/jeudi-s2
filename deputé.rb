require 'rubygems'
require 'nokogiri'
require 'open-uri'



@my_hash = []
def depute_informations
  listing_depute
end

def listing_depute
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  page.css('.col3 > li > a').each do |node|
    url_depute = node.values #de base met en array
  #puts node
    name_and_email(url_depute)
  end
end

def name_and_email(url_depute)
  email =[]#tableau vide de email
  name = []#tableau vide de name
  page2 = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr#{url_depute[0]}"))
  puts url_depute
  page2.xpath('//a[@class = "email"]').each do |node|#pour faire la recherche de email par rapport  a la class utiliser sur le site
    supp = node.values[1].delete_prefix('mailto:')
  #on lui dit de supprimer le mailto devant chaque adresse email
    email << supp
     #on met supp dans email
  end
  name << page2.xpath('//h1').text #on met page2 dans name on oublie pas de le mettre en .text
  @my_hash = name.zip(email).to_h#on reunie les 2 dans my hash qui etait jusqu'a l'ordre vide
  puts @my_hash #affiche la clef et la valeur

end

puts depute_informations
