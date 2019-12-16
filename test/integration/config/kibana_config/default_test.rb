title "Elasticsearch elasticsearch.yml configuration test suite"

describe file('/opt/elasticsearch/config/elasticsearch.yml') do
  it { should exist }
  its('owner') { should eq 'elasticsearch' }
  its('group') { should eq 'elasticsearch' }
  its('mode') { should cmp '0644' }

  its('content') { should match("node.name:") }
  its('content') { should match("path.data:") }
  its('content') { should match("path:") }
  its('content') { should match("logs:") }
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
