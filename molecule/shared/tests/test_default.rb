# Verify that redis, rabbitmq-server, sensu-{api,client}, and Uchiwa
# are all listening as expected
# frozen_string_literal: true

# Redis
describe port(6379) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should be_in ['0.0.0.0'] }
end

# RabbitMQ Server
describe port(5671) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should be_in ['0.0.0.0', '[::]'] }
end

# Sensu API
describe port(4567) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should be_in ['0.0.0.0'] }
end

# Sensu Client TCP/UDP Socket
describe port(3030) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  # Broken on 14.04 - its('protocols') { should include 'udp' }
  its('addresses') { should include '127.0.0.1' }
end

# Sensu Client HTTP Socket
describe port(3031) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should include '127.0.0.1' }
end

# Uchiwa
describe port(3000) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should be_in ['0.0.0.0', '[::]'] }
end

# Ensure Sensu API has one consumer
describe http('http://127.0.0.1:4567/health',
              auth: { user: 'admin', pass: 'secret' },
              params: { consumers: 1 }) do
  its('status') { should eq 204 }
end

# Ensure disk check exists
describe json('/etc/sensu/conf.d/sensu_masters/check_disk_usage.json') do
  its(%w[checks check_disk_usage command]) \
    { should eq 'check-disk-usage.rb' }
  its(%w[checks check_disk_usage interval]) { should eq 120 }
end

# Ensure disk metrics exists
describe json('/etc/sensu/conf.d/sensu_checks/metrics_disk_usage.json') do
  its(%w[checks metrics_disk_usage command]) \
    { should eq 'metrics-disk-usage.rb' }
  its(%w[checks metrics_disk_usage interval]) { should eq 60 }
end

# Ensure not_used does not exist
describe file('/etc/sensu/conf.d/not_used/not_a_check.json') do
  it { should_not exist }
end
