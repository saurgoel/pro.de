require 'yaml'

config = YAML::load_file(File.join(__dir__, 'config.yml'))
@name = config["name"]
@email = config["email"]
@username = config["username"]