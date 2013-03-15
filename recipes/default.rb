#cookbook Name:: defaults_configuration
# Recipe:: default
#
# Copyright 2013, Johannes Raufeisen
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
current_profile = "#{node[:current_profile]}"

execute "defaults write com.apple.dock no-glass -boolean #{node.default[:profiles][:"#{current_profile}"][:"2D-Dock"]} && killall Dock " do

  if "#{node.default[:profiles][:"#{current_profile}"][:"2D-Dock"]}" == "YES" 
    only_if "defaults read com.apple.dock no-glass | grep '0'" 
  end
  if "#{node.default[:profiles][:"#{current_profile}"][:"2D-Dock"]}" == "NO"
    only_if "defaults read com.apple.dock no-glass | grep '1'" 
  end
 
end


execute "defaults write com.apple.dashboard mcx-disabled -boolean #{node.default[:profiles][:"#{current_profile}"][:"Dashboard_disabled"]} && killall Dock " do

  if "#{node.default[:profiles][:"#{current_profile}"][:"Dashboard_disabled"]}" == "YES"                
    only_if "defaults read com.apple.dashboard mcx-disabled -boolean  | grep '0'"         
  end
  if "#{node.default[:profiles][:"#{current_profile}"][:"Dashboard_disabled"]}" == "NO"
    only_if "defaults read com.apple.dashboard mcx-disabled -boolean | grep '1'" 
  end
end



execute "defaults write com.apple.finder CreateDesktop #{node.default[:profiles][:"#{current_profile}"][:"Desktop_visible"]} && killall Finder" do 
  if "#{node.default[:profiles][:"#{current_profile}"][:"Desktop_visible"]}" == "YES"                
    only_if "defaults read com.apple.finder CreateDesktop  | grep 'NO'"
  end
  if "#{node.default[:profiles][:"#{current_profile}"][:"Desktop_visible"]}" == "NO" 
    only_if "defaults read com.apple.finder CreateDesktop | grep 'YES'" 
  end
end

node.default[:profiles][:"#{current_profile}"][:"spaces_in_dock"].times do
  execute "defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type='spacer-tile';}'" do 
     
  end
end

execute "killall Dock" do
  only_if do 
    node.default[:profiles][:"#{current_profile}"][:"spaces_in_dock"] > 0
  end

end

execute "defaults write com.apple.dashboard devmode #{node.default[:profiles][:"#{current_profile}"][:"dashboard_widgets_on_desktop"]} && killall Dock" do
  if "#{node.default[:profiles][:"#{current_profile}"][:"dashboard_widgets_on_desktop"]}" == "YES"
    only_if "defaults read com.apple.dashboard devmode  | grep 'NO'" 
    end
  if "#{node.default[:profiles][:"#{current_profile}"][:"dashboard_widgets_on_desktop"]}" == "NO"
    only_if "defaults read com.apple.dashboard devmode | grep 'YES'" 
  end
end


