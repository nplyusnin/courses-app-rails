# README

## How run the project

```
cp https://github.com/nplyusnin/courses-app-rails
asdf install
cp docker-compose.yml.sample docker-compose.yml
docker compose up -d
bundle exec rake db:setup
bundle exec rails s
```

Open http://localhost:3000
