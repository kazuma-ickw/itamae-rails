include_recipe "../../cookbooks/nginx/default.rb"

template "/etc/nginx/conf.d/app.conf" do
  user "root"
  mode "644"
  variables(
    root_path: node[:app_dir]
  )
end
