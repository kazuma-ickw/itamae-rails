execute "ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime"

remote_file "/etc/sysconfig/clock" do
  owner "root"
  group "root"
end
