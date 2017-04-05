## Pro.De
Simpe tools built on Mina to provision and deploy servers.

common_private - private scripts
common_public - public scripts

deployer_private - private deploy scripts
deployer_public - public deploy scripts

provisioner_private - private provision scripts
provisioner_public - public provision scripts


change to current directory
setting up inital folders and copying files (copying config files etc.)
Initial Setup: mina setup
Actual deployment
mina deploy -f config/deploy.rb
mina deploy -f config/deploy_staging.rb
mina ssh -f deploy.rb
Console: mina console
Logs: mina logs:production, mina logs:unicorn


mina [OPTIONS] [TASKS] [VAR1=val VAR2=val ...]
options
-v / --verbose - This will show commands being done on the server. Off by default.
-S / --simulate - This will not invoke any SSH connections; instead, it will simply output the script it builds.
-t / --trace - Show backtraces when errors occur.
-f FILE - Use a custom deploy.rb configuration.
-V / --version - Shows the current version.
mina restart on=staging
This sets the ENV['on'] variable to 'staging'.
queue! - verbosing the command


mina help    # Show help
mina init    # Creates a sample config file
mina tasks   # Show all tasks

mina tasks -f provision.rb

adds command to queue
command
it will output the command if verbose is true
command

Sets up a site / First time setup of the environment
mina setup

Open an ssh session to the server and cd to deploy_to folder
mina ssh -f provision.rb