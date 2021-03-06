# workspace
require_relative "user"
require_relative "channel"
require "terminal-table"
require "pry"

class Workspace
  attr_reader :users, :channels, :selected, :list_users, :list_channels

  def initialize
    @users = SlackCli::User.list
    @channels = SlackCli::Channel.list
    @selected = nil
  end

  def select_channel(name)
    @selected = @channels.find do |channel|
      channel.name == name || channel.slack_id == name
    end
    if @selected == nil 
      puts "That channel does not exist" 
    else
      return @selected
    end
  end

  def select_user(name)
    @selected = @users.find do |user|
      user.name == name || user.slack_id == name
    end

    if @selected == nil 
      puts "That user does not exist" 
    else
      return @selected
    end
  end

  def show_details
    if @selected == nil
      raise SlackCli::SlackError, "No user or channel selected!"
    else
      @selected.details
    end
  end

  def send_message(message)
    if @selected == nil
      raise SlackCli::SlackError, "No user or channel selected!"
    else
      message.strip!
      if message.length == 0
        raise SlackCli::SlackError, "Message must cannot be nil or blank..."
      else
        @selected.post_message(@selected.slack_id, message)
      end
    end
  end

  def list_channels
    @channels.each do |channel|
      puts "Channel name: #{channel.name} 
        ID: #{channel.slack_id} 
        Topic: #{channel.topic}
        Member count:#{channel.member_count}"
    end
    return nil
  end

  def list_users
    @users.each do |user|
      puts "#{user.real_name} Slack ID: #{user.slack_id}"
    end
    return nil
  end
end
