[![Metabase Logo](http://www.metabase.com/images/logo.svg)](http://www.metabase.com/)

[Metabase](http://www.metabase.com/) is the easy, open source way for everyone in your company to ask questions and learn from data.

# Getting production Metabase data (dashboards, etc) locally

Metabase's setup is all stored in a postgres database. We can restore that locally, and use that to test things in development.


Install [Parity](https://github.com/thoughtbot/parity). Homebrew works well for this.

Ensure that you've got the a recent local warehouse database dump loaded into local postgres `warehouse_development` database.

Ensure that you have a `production` remote in `.git/config`, pointing at our Metabase heroku app:

```
[remote "production"]
	url = https://git.heroku.com/vendr-metabase.git
	fetch = +refs/heads/*:refs/remotes/production/*
```

Create your local `metabase_development` database:

```
$ createdb metabase_development
```

Load production metabase database locally:


```
$ development restore-from production
```

Update the `Warehouse` database connection locally, and remove pulses (so you don't send any pulse emails/slacks from dev):

```
$ psql -f dev/reset.sql metabase_development;
BEGIN
DELETE 15
DELETE 15
DELETE 18
DELETE 14
UPDATE 1
COMMIT
```

Run metabase locally. Fetch the latest `metabase.jar` and run:

```
$ java -jar metabase.jar
```

For more details, check out the [Heroku-specific deploy documentation](http://www.metabase.com/docs/latest/operations-guide/running-metabase-on-heroku.html) for help with:
* Upgrading beyond Heroku's free plan
* Deploying Metabase version updates to Heroku
* Troubleshooting
