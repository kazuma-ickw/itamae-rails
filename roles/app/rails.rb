require "itamae/secrets"

node[:secrets] = Itamae::Secrets(File.join(__dir__, "../../secret"))

package "mysql-devel" do
  user "root"
  action :install
end

git node["app_dir"] do
  repository node["repository"]
  destination node["app_dir"]
end

template "create .env" do
  action :create
  source "templates/.env.erb"
  path node["app_dir"] + "/.env"
  variables(
    mysql_user_name: node[:secrets][:mysql_user_name],
    mysql_password: node[:secrets][:mysql_password]
  )
end
