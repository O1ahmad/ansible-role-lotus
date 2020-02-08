title "Lotus configuration integration tests"

describe file('/opt/lotus/.lotus/config.toml') do
  it { should exist }
  its('owner') { should eq 'lotus' }
  its('group') { should eq 'lotus' }
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
