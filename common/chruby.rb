set :chruby_path, '/etc/profile.d/chruby.sh'

task :chruby, :env do |_, args|
  unless args[:env]
    puts "Task 'chruby' needs a Ruby version as an argument."
    puts "Example: invoke :'chruby[ruby-1.9.3-p392]'"
    exit 1
  end

  comment %{chruby to version: \\"#{args[:env]}\\"}
  command %{
    if [[ ! -s "#{fetch(:chruby_path)}" ]]; then
      echo "! chruby.sh init file not found"
      exit 1
    fi
  }
  command %{source #{fetch(:chruby_path)}}
  command %{chruby "#{args[:env]}" || exit 1}
end


bash "installing chruby from source" do
  user "root"
  code <<-EOH
    wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
    tar -xzvf chruby-0.3.9.tar.gz
    cd chruby-0.3.9/
    sudo make install
    ./scripts/setup.sh
    cd ..
    rm -rf chruby-0.3.9.tar.gz chruby-0.3.9
  EOH
end


<!-- Execute this finally -->
chruby 2.1.1

