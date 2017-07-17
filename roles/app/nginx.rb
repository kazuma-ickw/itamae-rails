include_recipe "../../cookbooks/nginx/default.rb"

template "/etc/nginx/conf.d/app.conf" do
  user "root"
  mode "644"
end
