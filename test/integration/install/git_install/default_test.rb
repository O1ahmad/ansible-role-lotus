title "Kibana service installation suite"

describe user('kibana') do
  it { should exist }
end

describe group('kibana') do
  it { should exist }
end

describe file('/opt/kibana/bin/kibana') do
  it { should exist }
  its('owner') { should eq 'kibana' }
  its('group') { should eq 'kibana' }
  its('mode') { should cmp '0775' }
end
