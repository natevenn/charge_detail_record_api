<h1 align=center>Charge Detail Record API</h1>

<p>The Charge Detail Record API provides a single post end point (/rates) that creates a detail record and a rate record and then returns a json object with the overall rate and the rate broken down into compoenents (energy, time, transaction).</p>

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
 "overall": 7.04
 "components": { "energy": 3.277, "time": 2.767, "transaction": 1 }
}
```

Getting Started:
---
install ruby-2.6.5 for macOS
```
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB*/ Check the rvm.io page that these keys are up-to-date
 
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
rvm install 2.6.5 --with-openssl-dir=/usr/local/opt/openssl
```

install bundler
```
gem install bundler
```

clone the repo
```
git clone git@github.com:natevenn/charge_detail_record_api.git
```

**cd into the project** then run the following:

bundle the dependencies
```
bundle install
```

Database creation and migration
```
rake db:create db:migrate
```

run the test suite
```
rspec spec
```

running the application:
from the commandline in the ruby project run
```
rails server
```



