# Custom username and password (pass that )

desc "Install Nodejs"
task :'nodejs:install' do
  comment %{Installing Nodejs}
  command %{sudo yum install -y nodejs}
end

desc "Testing Nodejs Installation"
task :'nodejs:test' do
end
