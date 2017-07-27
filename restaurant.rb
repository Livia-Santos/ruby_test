require 'terminal-table'

class MenuItem
  attr_accessor :name, :price, :description

  def initialize(name, price, description="N/A")
    @name = name
    @price = price
    @description = description
  end
end


class Order

  def initialize()
    @items = []
  end

  attr_accessor :items, :name, :price

  def welcome
    puts "Welcome to Brazilan Taste Restaurant".center(60, "=")
    sleep 1
    main
  end

  def main
    option = nil
    until option == 5 do
      puts "1. Show food menu"
      puts "2. Order items"
      puts "3. Ask for bill"
      puts "x. Exit"
      print "> "

      option = gets.chomp.downcase

      case option
        when"1"
          system "clear"
          display_menu
        when"2"
          order_item
        when"3"
          pay
        when"x"
          exit(0)
        else
          puts "Invalid choice: #{option}"
      end
    end
  end

  MENU_ITEMS = [
    MenuItem.new('Steak', 20, "Very Good"),
    MenuItem.new('Parma', 15, "Not Vegetarian Frendly"),
    MenuItem.new('Eggplant Casserole', 15, "Vegan Choice"),
    MenuItem.new('Chips', 7, "Goes well with beer"),
    MenuItem.new('Beer', 7, "A good call for a friday arvo"),
    MenuItem.new('Soft drink', 3.50, "Refreshing")
  ]

  MENU_DESSERTES = [
    MenuItem.new('Tiramisu', 15, "A real classic"),
    MenuItem.new('Cheesecake', 10, "Made you the best milk ever!"),
    MenuItem.new('Tarte tatin', 15, "So French..humm"),
    MenuItem.new('Lemon tart', 10, "Summer taste")
  ]
  MENU_DRINKS = [
    MenuItem.new('Martini', 10),
    MenuItem.new('Margarita', 12),
    MenuItem.new('Negroni', 15),
    MenuItem.new('Mojito', 11),
  ]

  def display_menu
    puts "MENU".center(60, "-")
    MENU_ITEMS.each_with_index do |menu_item, index|
      user_index = index + 1
      # Display item with index first, then name and price
      puts "#{user_index}. | #{menu_item.name}: #{menu_item.price}"
      puts "-" * 60
    end
    puts "Want to see Items description? Y/N"
    option = gets.chomp.downcase
    display_items_description if option == 'y'
  end

  def display_items_description
    MENU_ITEMS.each_with_index do |menu_item, index|
      user_index = index + 1
      # Display item with index first, then name and price
      puts "#{user_index}. | #{menu_item.name}: #{menu_item.description}"
      puts "-" * 60
    end
    gets

  end

  def << (menu_item)
    @items << menu_item
  end

  def total
    total = 0
    @order.items.each do |item|
      total += item.price
    end
    total
  end

  def pay
    loop do
      puts "How do you wanna pay, CARD or CASH ?"
      option = gets.chomp.downcase
      puts option
      if option == "card"
        @order << MenuItem.new('Surcharge', total * 0.15, "Surcharge")
        puts bill
        break
      elsif option == 'cash'
        puts bill
        break
      else
        puts "Payment type not avaiable"
      end
    end
    puts "Thank's for choosing us, Tchau Tchau!"
    exit(0)
  end

  def bill
    if @order == nil
      "You need to order first"
    else
      table = Terminal::Table.new headings: ['Name', 'Price'] do |t|
        @order.items.each do |item|
          t << [item.name, "$#{item.price}"]
        end
        t.add_separator
        t << ['TOTAL', total.to_s]
      end
      table
    end
  end


  def order_item
    system 'clear'
    display_menu
    @order = Order.new
    loop do
      puts 'What would you like?'
      choice = gets.chomp
      break if choice == ""
      user_index = choice.to_i
      if user_index == 0
        "Invalid choice, please try again"
        next
      end
      index = user_index - 1
      menu_item = MENU_ITEMS[index]
      @order << menu_item
    end
    complete_order
  end

  def  complete_order
    puts ""
    puts "Your order is: ".upcase
    puts " "
      @order.items.each_with_index do |item, index|
        puts "#{index + 1} - #{item.name}"
        puts "-" * 60
      end
    gets
    puts 'Thank you'
    puts ''
  end
end



# sleep 2
# puts 'I hope you enjoyed your meal. Here is your bill:'
# puts order.bill

Order.new.welcome
