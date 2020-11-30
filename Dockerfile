#FROM ubuntu:16.04
#
#RUN apt-get update
#RUN apt-get install -y git-core \
#curl zlib1g-dev build-essential libssl-dev \
#libreadline-dev libyaml-dev libsqlite3-dev \
#sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev \
#libmysqlclient-dev python-software-properties tzdata
## libmysqlclient-dev는 bundle update시 mysql2 오류 해결
## tzdata bundle을 불러올 수 없는 오류 해결
#
##WORKDIR /
##RUN cd ~ rm -rf .rbenv/
#RUN git clone git://github.com/sstephenson/rbenv.git .rbenv
#RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
#ENV PATH $HOME/.rbenv/bin:$PATH
#RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#RUN exec $SHELL
#
#RUN git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
#RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
#ENV PATH $HOME/.rbenv/plugins/ruby-build/bin:$PATH
#RUN exec $SHELL
#
#RUN rbenv install 2.6.6
#RUN rbenv global 2.6.6
#RUN rbenv init -
#RUN echo ruby -v
#
#RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
#
##RUN add-apt-repository ppa:chris-lea/node.js
##RUN apt-get update
#RUN apt-get install -y npm
##RUN npm cache clean -f
#RUN npm install -g n
#RUN n stable
#RUN npm install -g yarn
#
#ADD . /Rails_Project/Board_with_Ruby
#WORKDIR /Rails_Project/Board_with_Ruby
#
#RUN gem install bundler
#RUN gem install rails
#RUN rbenv rehash
#
#RUN bundle update
#RUN bundle install
#RUN yarn install --check-files
#
#EXPOSE 80
#
#CMD rails server -b localhost -p 80 -e development

# install ruby slim version
FROM ruby:2.6.6-slim

# installing required tools
RUN apt-get update
RUN apt-get install -y \
git-core \
curl \
zlib1g-dev \
build-essential \
libssl-dev \
libreadline-dev \
libyaml-dev \
libsqlite3-dev \
sqlite3 \
libxml2-dev \
libxslt1-dev \
libcurl4-openssl-dev \
libmariadb-dev-compat \
libmariadb-dev \
software-properties-common \
tzdata \
npm

RUN gem install bundler
RUN gem install rails

# nodejs version management tool
RUN npm install -g n
# install nodejs stable version
RUN n stable
# install yarn for use 'yarn install --check-files'
RUN npm install -g yarn

# copy project folder to docker container
ADD ./ /Project/Board_with_Ruby
# change work directory in docker container
WORKDIR /Project/Board_with_Ruby

# install ruby bundle in Gemfile
RUN bundle install
# node_modules
RUN yarn install --check-files

#RUN rake db:create
#RUN rake db:migrate

EXPOSE 80
CMD rails server -b 0.0.0.0 -p 80 -e development