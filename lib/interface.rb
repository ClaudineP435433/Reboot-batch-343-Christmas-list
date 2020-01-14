require_relative 'methods'

GIFTS = [
  {name: "socks", price: 13, bought: false},
  {name: "glass", price: 50, bought: true }
]

puts "-"*30
puts "My Christmas List"
puts "-"*30

loop do
  display_menu
  action = gets.chomp

  case action
  when '1' then display_gifts(GIFTS)
  when '2' then add_a_gift(GIFTS)
  when '3' then delete_a_gift(GIFTS)
  when '4' then mark_as_bought(GIFTS)
  when '5' then scrap_ideas(GIFTS)
  when '6' then break
  end
end
