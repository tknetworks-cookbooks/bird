name             "bird"
maintainer       "TKNetworks"
maintainer_email "nabeken@tknetworks.org"
license          "Apache 2.0"
description      "Installs/Configures bird"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{chef-openbsd openbsd sysctl}.each do |r|
  depends r
end
