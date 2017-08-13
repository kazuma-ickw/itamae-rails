require "itamae/secrets"

node[:secrets] = Itamae::Secrets(File.join(__dir__, "../../secret"))

include_recipe "../../cookbooks/imagemagick/default.rb"

package "mysql-devel" do
  user "root"
  action :install
end

file "/home/#{node.users.first.name}/.ssh/id_rsa" do
  action :create
  user node.users.first.name
  mode "600"
  content node[:secrets][:deploy_key]
end

file "/home/#{node.users.first.name}/.ssh/config" do
  action :create
  user node.users.first.name
  mode "600"
  content "StrictHostKeyChecking no"
end

directory node["app_dir"] do
  owner node.users.first.name
  mode "755"
end

git node["app_dir"] do
  user node.users.first.name
  repository node["repository"]
  destination node["app_dir"]
end

template "create .env" do
  action :create
  source "templates/.env.erb"
  path node["app_dir"] + "/.env"
  variables(
    mysql_user_name: node[:secrets][:mysql_user_name],
    mysql_password: node[:secrets][:mysql_password],
    mysql_host: node[:secrets][:mysql_host]
  )
end
