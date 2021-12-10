<h1 align=center>Charge Detail Record API</h1>

<p>The Charge Detail Record API provides a single post end point (/rate) that creates a detail record and a rate record and then returns a json object with the overall rate and the rate broken down into compoenents (energy, time, transaction).</p>

example of the input
```json
{
 "rate": { "energy": 0.3, "time": 2, "transaction": 1 },
 "cdr": { "meterStart": 1204307, "timestampStart": "2021-04-05T10:04:00Z", "meterStop": 1215230, "timestampStop":
"2021-04-05T11:27:00Z" }
}
```
example of the output
```json
{
 "overall": 7.04,
 "components": { "energy": 3.277, "time": 2.767, "transaction": 1 }
}
```

Getting Started:
---
ruby verion 2.6.5


clone the repo
```
$ git clone https://github.com/natevenn/charge_detail_record_api.git
```

**cd into the project** then run the following:

install bundler version 2.2.11
```
$ gem install bundler:2.2.11
```
use bundler version 2.2.11
```
$ bundle _2.2.11_ install
```

bundle the dependencies
```
$ bundle install
```

Database creation and migration
```
$ rake db:create db:migrate db:test:prepare
```

run the test suite
```
$ RAILS_ENV=test rspec spec
```

running the application:
```
$ rails server
```
example post request via curl
```
$ curl --header "Content-Type: application/json" \
  --request POST \
  --data '{
  "rate": { "energy": 0.3, "time": 2, "transaction": 1 },
  "cdr": { "meterStart": 1204307, "timestampStart": "2021-04-05T10:04:00Z", "meterStop": 1215230, "timestampStop":
  "2021-04-05T11:27:00Z" }
}' \
  http://localhost:3000/rate
```

## Docker

Start rails application

    docker-compose up -d

Build database

    docker-compose run web rake db:migrate

Run tests

    docker-compose run web rspec spec