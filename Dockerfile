FROM ruby:3.4.4

RUN bundle config --global frozen 1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y \
    build-essential \
    yarn \
    libpq-dev \
    nodejs \
    imagemagick \
    libvips \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4

COPY package.json yarn.lock ./
RUN yarn install

RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

COPY . .

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]