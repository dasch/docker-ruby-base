FROM ubuntu

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -yq wget build-essential libxslt-dev libxml2-dev

# Install ruby-install.
RUN wget --no-check-certificate -O ruby-install-0.3.4.tar.gz https://github.com/postmodern/ruby-install/archive/v0.3.4.tar.gz
RUN tar -xzvf ruby-install-0.3.4.tar.gz
RUN cd ruby-install-0.3.4/ && make install
RUN rm -fr ruby-install-0.3.4.tar.gz ruby-install-0.3.4/

# Install Ruby 2.0.0.
RUN ruby-install -i /usr/local ruby 2.0.0 -- --disable-install-doc

# Avoid parsing RDoc documentation when installing gems.
RUN echo "install: --no-rdoc --no-ri" > /usr/local/etc/gemrc

# Install Bundler.
RUN gem install bundler
