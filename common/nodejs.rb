# Custom username and password (pass that )
namespace :nodejs do
  desc "Install Nodejs"
  task :install do
    comment %{Installing Nodejs}
    command %{yum install -y nodejs}
  end

  task :test do
  end

end