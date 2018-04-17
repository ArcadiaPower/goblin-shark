# goblin-shark
_An Experiment in Modeling Billing Systems_

Currently this is a small code sample to explore Ruby's [Observable](https://docs.ruby-lang.org/en/2.4.0/Observable.html) module and how it might behave with ActiveRecord and AASM.

## How it works
When a `BillItem` is initialized, it registers a `Bill` object as an observer.

Whenever we `save!` on the `BillItem`, we notify the observer that a change has occured and to execute the appropriate function.

`Bill` receives this notification message and executes the `update_total` method, this updating the `Bill` total.

## Development

If you need to edit the schema or update the annotations, set `ENVIRONMENT = 'development'` in the `init.rb` file.

When testing, set `ENVIRONMENT = 'test'` and run `rspec spec/`.

We're using a SQLite3 in-memory [database](https://www.sqlite.org/inmemorydb.html) so all database connections sharing the in-memory database need to be in the same process.
The database is automatically deleted and memory is reclaimed when the last connection to the database closes.
