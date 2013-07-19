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
require 'minitest/spec'

describe_recipe 'bird::inet' do
  it 'installs bird' do
    package('bird').must_be_installed
  end

  it 'creates bird.conf' do
    conf = file('/etc/bird.conf')
    conf.must_exist.with(:owner, 'root').with(:group, 'wheel').with(:mode, 0600)
    conf.must_include 'protocol kernel {'
  end

  it 'starts/enables bird' do
    s = service('bird')
    s.must_be_enabled
    s.must_be_running
    assert_sh "grep '\\-c /etc/bird.conf -s /var/run/bird.ctl' /etc/rc.conf.local"
  end

  it 'enable ip forwarding' do
    assert_sh '[ "$(sysctl net.inet.ip.forwarding | cut -d= -f2)" = "1" ]'
  end
end
