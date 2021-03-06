require_relative "workspace"

# :nocov:
def main
  workspace = Workspace.new
  puts "TatiHana Slack Channels loaded #{SlackCli::Channel.list.length} channels"
  puts "TatiHana Users loaded #{SlackCli::User.list.length} users"

  def options
    puts "Please choose one of the following options:
    - list users
    - list channels
    - select user
    - select channel
    - details
    - send message
    - quit
    Enter your choice now:"
    # selected = false
  end

  options
  choice = gets.chomp
  loop do
    case choice
    when "list users"
      puts workspace.list_users
    when "list channels"
      puts workspace.list_channels
    when "select user"
      puts "what user would you like to select?"
      selected_user = gets.chomp
      workspace.select_user(selected_user)
    when "select channel"
      puts "What channel would you like to select?"
      selected_channel = gets.chomp
      workspace.select_channel(selected_channel)
    when "details"
      begin
        puts workspace.show_details
      rescue
        puts "No user or channel selected, try again."
      end
    when "send message"
      if workspace.selected == nil
        puts "No user or channel selected"
      else
        # begin
        message = gets.chomp
        workspace.send_message(message)
        # rescue SlackCli::SlackError
        puts "No user or channel selected, try again"
        # end
      end
    when "quit"
      puts "Thanks for checking out TatiHana! Bye bye..."
      exit
    end
    options
    choice = gets.chomp
  end
end

main if __FILE__ == $0
# :nocov:
