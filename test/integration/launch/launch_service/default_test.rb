title "Lotus storage client/service launch test suite"

describe file('/etc/systemd/system/lotus.service') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }
end

describe service('lotus') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
