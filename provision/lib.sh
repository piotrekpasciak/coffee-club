function provision_locale {
  sudo /usr/sbin/update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
  source /etc/default/locale
}
function provision_apt {
  sudo apt-get update
  sudo apt-get install -y $@
}
function provision_ruby {
  git clone 'https://github.com/sstephenson/rbenv.git' ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"'               >> ~/.bashrc
  source ~/.bashrc
  git clone 'https://github.com/sstephenson/ruby-build.git' ~/.rbenv/plugins/ruby-build
  sudo -H -u vagrant bash -i -c "rbenv install $1"
  sudo -H -u vagrant bash -i -c 'rbenv rehash'
  sudo -H -u vagrant bash -i -c "rbenv global $1"
}
function provision_bundler {
  #gitlab key for our secret gems
  echo "|1|KpPvN4urt0MfrBJDoLc77MFAIns=|HA37DymnwE/YhvzUYcfzpgqeP3w= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBC21Zp83nr6Bk8dOQQMMkQ/ve8HmFnSkmEGqZYBZJx6OHdbL172jG8tJh58s3to9ERzrkd/eDNsX3L63ebUazm8=" >> ~/.ssh/known_hosts
  echo "|1|KZSEDxhZb3LM7vE6r1WXziA678A=|Hj1fVIrZAahfkJmRhi56z2CrYZQ= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBC21Zp83nr6Bk8dOQQMMkQ/ve8HmFnSkmEGqZYBZJx6OHdbL172jG8tJh58s3to9ERzrkd/eDNsX3L63ebUazm8<Paste>=" >> ~/.ssh/known_hosts
  sudo -H -u vagrant bash -i -c 'gem install bundler --no-ri --no-rdoc'
  sudo -H -u vagrant bash -i -c 'rbenv rehash'

}
function provision_postgres {
  sudo cp /home/vagrant/src/provision/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
  sudo service postgresql restart
}
function provision_app {
  cp /home/vagrant/src/provision/*.yml /home/vagrant/config/
  sudo -H -E -u vagrant bash -i -c 'cd src && bundle install && bundle exec sunspot-solr start && bundle exec rake db:create db:schema:load db:seed; cd'
  # reindex has to be separate, because of reasons
  # (namely seeds having to disable indexing in a hackish way to work)
}
APT_PACKAGES="postgresql git rbenv ruby-build autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev  curl git-core python-software-properties ruby-dev libpq-dev build-essential nginx libsqlite3-0 libsqlite3-dev libxml2 libxml2-dev libxslt1-dev nodejs postgresql postgresql-contrib solr-common"
