# Install Atlassian Stash
# This is a trusted build, we need postgresql
FROM linux/postgres

MAINTAINER Nick Zalutskiy pacemkr@gmail.com

# Prepare all the files
ENV AppName stash
ENV AppVer 3.0.1
ENV STASH_HOME /vagrant/stash-home
ENV STASHUSR stash
ADD http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash-3.0.1.tar.gz /opt/atlassian/
# stash.rb is to create the database
ADD ./chef/recipes/stash.rb /etc/chef/cookbooks/database/recipes/stash.rb
ADD ./install_cmds.sh /install_cmds.sh
ADD ./node.json /etc/chef/node.json
ADD ./install_cmds.sh /install_cmds.sh
ADD ./init.sh /init.sh

# Uncomment to enable backup of files on host
VOLUME ["/vagrant"]

## Now Install Atlassian Jira
RUN /install_cmds.sh

# Start the service
CMD ["sh", "/init.sh"]

# Http Port
EXPOSE 7990

# SSH Port
EXPOSE 7999
