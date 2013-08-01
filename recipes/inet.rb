#
# Author:: Ken-ichi TANABE (<nabeken@tknetworks.org>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
sysctl "net.inet.ip.forwarding" do
  value 1
  comment "Permit forwarding (routing) of IPv4 packets"
end

package 'bird' do
  action :install
end

template node['bird']['inet']['conf'] do
  owner 'root'
  group node['etc']['passwd']['root']['gid']
  mode 0600
  source 'bird.conf.erb'
end

service "bird" do
  action [:enable, :start]
  if node['platform'] == 'openbsd'
    parameters({:flags => " -c /etc/bird.conf -s /var/run/bird.ctl",
                :pkg_script => true})
  end
end
