include_recipe "../../cookbooks/timezone/default.rb"
include_recipe "./user.rb"
include_recipe "./nginx.rb"
include_recipe "./rails.rb"
