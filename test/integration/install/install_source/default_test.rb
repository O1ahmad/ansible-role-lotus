title "Lotus source installation integration tests"

describe file('/opt/lotus') do
  it { should exist }
end

describe file('/usr/local/bin/lotus') do
  it { should exist }
  its('mode') { should cmp '00755' }
end

describe command('/usr/local/bin/lotus --help') do
  its('exit_status') { should eq 0 }
end
