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
sysctl 'net.inet6.ip6.forwarding' do
  value 1
  comment 'Permit forwarding (routing) of IPv6 packets'
end

package node['bird']['inet6']['package'] do
  action :install
end

template node['bird']['inet6']['conf'] do
  owner 'root'
  group node['etc']['passwd']['root']['gid']
  source 'bird6.conf.erb'
  mode 0600
end

service 'bird6' do
  action [:enable, :start]
  if node['platform'] == 'openbsd'
    parameters({:flags => " -c /etc/bird6.conf -s /var/run/bird6.ctl",
                :pkg_script => true})
  end
end
