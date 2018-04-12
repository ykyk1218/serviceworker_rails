FROM ruby:2.4
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       curl \
       git \
       zlib1g-dev \
       libssl-dev \
       libreadline-dev \
       libyaml-dev \
       libxml2-dev \
       libxslt-dev \
       libmysqlclient-dev

RUN apt-get autoclean && \
      apt-get clean && \
      apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 40976EAF437D05B5
RUN apt-get update && apt-get install -y apt-file
RUN apt-file update && apt-get install -y software-properties-common && apt-get update
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
      apt-get update && apt-get install -y yarn

RUN rm -rf /var/lib/apt/lists/

RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
#ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
#CMD bundle exec puma -C config/puma.rb
EXPOSE 3000
EXPOSE 3035
