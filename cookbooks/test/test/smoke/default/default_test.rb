# # encoding: utf-8

# Inspec test for recipe test::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
  describe user('vagrant'), :skip do
    it { should exist }
    it { should have_home_directory '/home/vagrant' }
  end
end
describe docker.version do
  its('Server.Version') { should cmp >= '1.12'}
  its('Client.Version') { should cmp >= '1.12'}
end
