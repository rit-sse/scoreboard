# Scoreboard
[![Build Status](https://travis-ci.org/rit-sse/scoreboard.svg)](https://travis-ci.org/rit-sse/scoreboard)
[![Code Climate](https://codeclimate.com/github/rit-sse/scoreboard/badges/gpa.svg)](https://codeclimate.com/github/rit-sse/scoreboard)
[![Test Coverage](https://codeclimate.com/github/rit-sse/scoreboard/badges/coverage.svg)](https://codeclimate.com/github/rit-sse/scoreboard)

SSE Membership Tracker built using Padrino.

# Development

```
git clone https://github.com/rit-sse/scoreboard.git
cd scoreboard
bundle install --without production
bower install
bundle exec rake db:migrate
padrino start
```
Navigate to `http://localhost:3000/scoreboard`
