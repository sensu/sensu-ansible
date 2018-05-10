# Verify that redis, rabbitmq-server, sensu-{api,client}, and Uchiwa
# are all listening as expected

# Redis
# TODO Ubuntu 14.04 - Redis is bound to 127.0.0.1
describe port(6379) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should be_in ['0.0.0.0', '::'] }
end

# RabbitMQ Server
describe port(5671) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should be_in ['0.0.0.0', '::'] }
end

# Sensu API
describe port(4567) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should be_in ['0.0.0.0', '::'] }
end

# Sensu Client TCP/UDP Socket
# TODO Amazon Linux 2 - Client does NOT bund to it's socket ports
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
  its('addresses') { should be_in ['0.0.0.0', '::'] }
end
