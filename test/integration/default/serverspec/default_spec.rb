require 'serverspec'
require_relative './spec_helper'

# Required by serverspec
set :backend, :exec

describe file(ENV['htslib_DIR']) do
  it { should be_directory }
end

file_path = ENV['htslib_DIR'] + '/htsfile'
describe file(file_path) do
  it { should be_executable }
end

file_path = ENV['htslib_DIR'] + '/htslib'
describe file(file_path) do
  it { should be_directory }
end

describe command('which htsfile') do
  its(:exit_status) { should eq 0 }
end

describe command('htsfile --version') do
  its(:stdout) { should contain(ENV['htslib_VERSION']) }
end
