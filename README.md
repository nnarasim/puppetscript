# puppetscript


sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

yum install puppet-agent

sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

--> test--> sudo /opt/puppetlabs/bin/puppet agent --test

sudo /opt/puppetlabs/bin/puppet cert list
sudo /opt/puppetlabs/bin/puppet cert sign <NAME>

(or) sudo /opt/puppetlabs/bin/puppet cert sign -all