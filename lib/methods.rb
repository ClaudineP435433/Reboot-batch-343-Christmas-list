require_relative 'scrapper'

def display_menu
  puts 'What do you want to do ?'
  puts '1 - Display all gifts'
  puts '2 - Add a gift'
  puts '3 - Delete a gift'
  puts '4 - Mark a gift as bought'
  puts '5 - Scrap Ideas from Etsy'
  puts '6 - Quit'
end

def display_gifts(gifts)
  puts '-'*12
  puts ' Gift List'

  gifts.each_with_index do |gift, index|
    #si gift bought est égale true => [X] sinon []

    if gift[:bought] == true
      bought = "[X]"
    else
      bought = "[ ]"
    end

    # condition ? réponse si vrai : réponse si faux
    # bought = ( gift[:bought] == true ?  "[X]" : "[ ]")
    # bought = gift[:bought] ?  "[X]" : "[ ]"
    puts "#{index + 1}. #{gift[:name]} - #{gift[:price]}€ #{bought}"
  end
  puts '-'*12
end


def add_a_gift(gifts)
  # demander à l'utilisateur nom du cadeau et le stocker
  puts 'What is the name of the gift you want to add ?'
  name = gets.chomp
  # demander à l'utilisateur prix du cadeau et le stocker
  puts 'What is the price of the gift you want to add ?'
  price = gets.chomp.to_i
  # gift sous le format de hash
  gift = {
    name: name,
    price: price,
    bought: false
  }
  # ajouter le gift créé à la liste des cadeaux
  gifts << gift
  display_gifts(gifts)
  save_csv(gifts)
end

def delete_a_gift(gifts)
  #ask the question "what do you want to delete?"
  # stock the answer as a variable (index) convert to integer
  # look in the gifts array and find the index of this gift
  # delete the gift belonging to this index
  display_gifts(gifts)
  puts "Which gift number do you want to delete?"
  index = gets.chomp.to_i
  gifts.delete_at(index - 1)
  display_gifts(gifts)
  save_csv(gifts)
end


def mark_as_bought(gifts)
  # puts "What do you want to mark as bought ?"
  puts "What would you like to mark as bought ? "
  #Afficher la liste pour rappel
  display_gifts(gifts)
  # stocker la réponse
  index = gets.chomp.to_i
  # Retrouver le cadeau concerné grâce à l'index
  gift = gifts[index - 1]
  # Modifier la clé "bought"
  gift[:bought] = true
  # gifts[index - 1][:bought] = true
  # Réafficher la liste actualisée
  display_gifts(gifts)
  save_csv(gifts)
end


def scrap_ideas(gifts)
  # ask user for what is he looking for
  puts "What are you looking for ?"
  # define the variable article
  article = gets.chomp
  suggestion = scrapper(article)
  # url https://www.etsy.com/fr/search?q=socks
  # remplacer dans l'url socks par article
  # réaliser le scrapping => liste avec les noms des cartes
  display_gifts(suggestion)
  puts "Wich gift would you want to add ?"
  index = gets.chomp.to_i
  gifts << suggestion[index - 1]
  display_gifts(gifts)
  # demander à l'utilisateur de choisir quel cadeau de la liste scrappée il veut ajouter
  # ajouter un nouveau cadeau à la liste
  save_csv(gifts)
end



def load_csv
  filepath = 'lib/gifts.csv'
  gifts = []

  CSV.foreach(filepath, { headers: :first_row }) do |row|
    gift = { name: row['name'], price: row['price'].to_i, bought: row['bought'] == "true" }
    gifts << gift
  end
  return gifts
end

def save_csv(gifts)
  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  filepath = 'lib/gifts.csv'

  CSV.open(filepath, 'wb', csv_options) do |csv|
    csv << ['name', 'price', 'bought']

    gifts.each do |gift|
      csv << [ gift[:name], gift[:price], gift[:bought] ]
    end
  end
end



