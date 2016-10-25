#!/usr/bin/env bash
source /home/vagrant/src/provision//lib.sh
RUBY_VERSION=2.3.1
provision_locale
provision_apt $APT_PACKAGES
provision_ruby $RUBY_VERSION
provision_bundler
provision_postgres
provision_app