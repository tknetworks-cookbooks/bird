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
default['bird']['inet']['conf'] = '/etc/bird.conf'
default['bird']['inet6']['conf'] = '/etc/bird6.conf'

default['bird']['inet']['sock'] = '/var/run/bird.ctl'
default['bird']['inet6']['sock'] = '/var/run/bird6.ctl'

default['bird']['inet6']['package'] = case platform
                                      when 'openbsd'
                                        'bird-v6'
                                      else
                                        'bird'
                                      end
