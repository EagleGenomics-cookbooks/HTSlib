describe file('/usr/local/htslib-1.3.1/') do
  it { should be_directory }
end

describe file('/usr/local/htslib-1.3.1/htsfile') do
  it { should be_executable }
end

describe file('/usr/local/htslib-1.3.1/htslib') do
  it { should be_directory }
end

describe command('. /etc/profile; which htsfile') do
  its('exit_status') { should eq 0 }
end

describe command('. /etc/profile; htsfile --version') do
  its('stdout') { should match(/1.3.1/) }
end
