# From https://stackoverflow.com/questions/38130370/executing-a-command-every-time-the-rails-console-starts
# By https://stackoverflow.com/users/321583/jeremy-baker
module ConsoleExtension
  # This module provides methods that are only available in the console
  module ConsoleHelpers
    def switch_company
      companies = Company.all.to_a
      puts "\n\n"
      puts "-" * 50
      companies.each_with_index { |c, i| puts "#{i} -  #{c.name} #{i.zero? ? '(Default)' : '' }"}
      print "Select active company (Enter for default): "
      choice = gets.chomp.to_i
      if selected_company = companies[choice]
        ApplicationRecord.current_company_id = selected_company.id
      else
        puts "Invalid entry"
      end
    end
  end

  # This is a simple class that allows us access to the ConsoleHelpers before
  # we get into the console
  class ConsoleRunner
    include ConsoleExtension::ConsoleHelpers
  end

  # This is specifically to patch into the startup behavior for the console.
  #
  # In the console_command.rb file, it does this right before start:
  #
  # if defined?(console::ExtendCommandBundle)
  #   console::ExtendCommandBundle.include(Rails::ConsoleMethods)
  # end
  #
  # This is a little tricky. We're defining an included method on this module
  # so that the Rails::ConsoleMethods module gets a self.included method.
  #
  # This causes the Rails::ConsoleMethods to run this code when it's included
  # in the console::ExtendCommandBundle at the last step before the console
  # starts, instead of during the earlier load_console stage.
  module ConsoleMethods
    def included(_klass)
      while ApplicationRecord.current_company_id.nil?
        ConsoleExtension::ConsoleRunner.new.switch_company
      end
    end
  end
end