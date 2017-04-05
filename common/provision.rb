require "mina/default"

set :execution_mode, :pretty

# All the commands passed to "command" are executed on the machine after ssh is done
desc "Sets up an instance for provisioning"
task :setup do
  # Tasks that would be run before custom provision setup task
  comment %{Connected to #{fetch(:domain)}}
  comment %{Setting up #{fetch(:domain)}}
end
