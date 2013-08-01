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
require 'spec_helper'

describe 'bird::inet6' do
  include_context 'openbsd'

  context 'on openbsd' do
    before do
      chef_run.converge('bird::inet6')
    end

    it 'should install bird6' do
      expect(chef_run).to install_package 'bird-v6'
    end

    it 'should create bird6.conf' do
      expect(chef_run).to create_file '/etc/bird6.conf'
      conf = chef_run.template('/etc/bird6.conf')
      expect(conf).to be_owned_by('root', 0)
      expect(conf.mode).to eq(0600)
    end

    it 'should enable/start bird6' do
      expect(chef_run).to enable_service 'bird6'
      expect(chef_run).to start_service 'bird6'
      params = {:flags => " -c /etc/bird6.conf -s /var/run/bird6.ctl",
                :pkg_script => true}
      expect(chef_run.service('bird6').parameters).to eq(params)
    end
  end
end
