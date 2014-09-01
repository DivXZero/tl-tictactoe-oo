
module Console
  def self.clear_screen
    system('cls')
    system('clear')
  end

  def self.get_input(msg = nil)
    puts "\n~> #{msg} :" unless msg == nil
    gets.chomp.to_s
  end

  def self.display_banner(msg)
    puts "~*~*~*~*~*~*~*~*~*~ #{msg} ~*~*~*~*~*~*~*~*~*~\n\n"
  end
end