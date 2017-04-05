require "mina/default"

set :execution_mode, :pretty

# All the commands passed to "command" are executed on the machine after ssh is done.
# Every command is executed from the base shell execution. 
# So if you do "cd something" or "sudo something" then in a separate line write a command, those commands wont have an effect
desc "Sets up an instance for provisioning"
task :setup do
  # Tasks that would be run before custom provision setup task
  comment %{Connected to #{fetch(:domain)}}
  comment %{Setting up #{fetch(:domain)}}
end
