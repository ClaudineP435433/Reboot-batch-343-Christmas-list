require_relative 'methods'

# GIFTS = [
#   {name: "socks", price: 13, bought: false},
#   {name: "glass", price: 50, bought: true }
# ]

puts "-"*30
puts "My Christmas List"
puts "-"*30

loop do
  display_menu
  gifts = load_csv
  action = gets.chomp

  case action
  when '1' then display_gifts(gifts)
  when '2' then add_a_gift(gifts)
  when '3' then delete_a_gift(gifts)
  when '4' then mark_as_bought(gifts)
  when '5' then scrap_ideas(gifts)
  when '6' then break
  end
end

# action = ''
# while action != '6'
#   display_menu
#   gifts = load_csv
#   action = gets.chomp
#   puts '-'*12

#   case action
#   when '1' then display_gifts(gifts)
#   when '2' then add_gift(gifts)
#   when '3' then validate_bought(gifts)
#   when '4' then delete_gift(gifts)
#   when '5' then find_item_on_etsy(gifts)
#   when '6' then puts 'Byebye'
#   else
#     puts 'Mauvaise commande essaye encore'
#   end
# end
