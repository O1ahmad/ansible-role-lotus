title "Lotus client/service uninstallation default test suite"

describe user('lotus') do
  it { should_not exist }
end

describe group('lotus') do
  it { should_not exist }
end

describe directory('/opt/lotus/.lotus') do
  it { should_not exist }
end

describe directory('/var/data/lotus') do
  it { should_not exist }
end

describe service('lotus') do
  it { should_not be_running }
end

describe file('/etc/systemd/system/lotus.service') do
  it { should_not exist }
end
