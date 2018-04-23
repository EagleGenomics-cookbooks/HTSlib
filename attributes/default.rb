default['htslib']['version'] = '1.8'
default['htslib']['install_path'] = '/usr/local'
default['htslib']['dir'] = default['htslib']['install_path'] + '/' + 'htslib-' + default['htslib']['version']
default['htslib']['filename'] = "htslib-#{node['htslib']['version']}.tar.bz2"
default['htslib']['url'] = "https://github.com/samtools/htslib/releases/download/#{node['htslib']['version']}/#{node['htslib']['filename']}"
