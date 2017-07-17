package "http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm" do
  user "root"
  action :install
end

package "nginx" do
  user "root"
  options "--enablerepo=nginx"
  action :install
end

# service "nginx" do
#   user "root"
#   action [:enable, :start]
# end
