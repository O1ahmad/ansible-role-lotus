title "Elasticsearch elasticsearch.yml configuration test suite"

describe file('/home/kitchen/.lotus/config.toml') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
  its('group') { should eq 'kitchen' }
  its('mode') { should cmp '0644' }

  its('content') { should match("[API]") }
  its('content') { should match("ListenAddress =") }
  its('content') { should match("Timeout =") }
  its('content') { should match("[Libp2p]") }
  its('content') { should match("ListenAddresses =") }
  its('content') { should match("[Metrics]") }
  its('content') { should match("Nickname =") }
  its('content') { should match("HeadNotifs =") }
  its('content') { should match("PubsubTracing =") }
end

describe directory('/mnt/logs/elasticsearch') do
  it { should exist }
  its('owner') { should eq 'elasticsearch' }
  its('group') { should eq 'elasticsearch' }
  its('mode') { should cmp '0755' }
end

describe directory('/mnt/data/elasticsearch') do
  it { should exist }
  its('owner') { should eq 'elasticsearch' }
  its('group') { should eq 'elasticsearch' }
  its('mode') { should cmp '0755' }
end
