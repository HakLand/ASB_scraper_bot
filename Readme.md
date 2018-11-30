About
=====

This thing will log into your online banking and scrape an account balance


Setup
====

```
git clone git@github.com:HakLand/ASB_scraper_bot.git

cd ASB_scraper_bot

gem install bundler

bundle
```

In a browser, right click on the balance HTML element of the account you're interested in in dev tools and 'copy css selector'.
Paste this in line 32 of `scrape.rb`.

Optionally setup a Slack webhook integration so it can post to your channel.

Run
===

```
ASBUSERNAME=username ASBPASSWORD='password' ruby scrape.rb
```

Post to webhook (Slack?)
===

Add in `WEBHOOK` to your environment variables

```
ASBUSERNAME=username ASBPASSWORD='password' WEBHOOK=https://hooks.slack.com/services/blahblah ruby scraper.rb
```

Run once a week with CRON and rvm
===

Install rvm

https://rvm.io/deployment/cron
```
rvm use ruby-2.3.3
rvm cron setup
crontab -e

32      3     *     *     6         ASBUSERNAME=username ASBPASSWORD='password' WEBHOOK=https://hooks.slack.com/services/blahblah ruby /home/users/someone/path_to_scraper/scraper.rb
```