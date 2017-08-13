package "ImageMagick" do
  user "root"
  action :install
end

package "ImageMagick-devel" do
  user "root"
  action :install
end
