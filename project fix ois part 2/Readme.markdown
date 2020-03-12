# ICS0013 2019 spring semester lab2 project template

## Project structure and files

Structure is inline with [RubyGems basics guide](https://guides.rubygems.org/rubygems-basics/) freewill example and [Learn Ruby the hard way Exercise 46: A Project Skeleton](https://learnrubythehardway.org/book/ex46.html) as far as applicable. Directories contain `.gitkeep` because Git does not track empty directories.

`.gitignore` contains common operating systems and ruby projects ignored files from [GitHub templates](https://github.com/github/gitignore). It is extended to ignore gitlab-runner builds, VS Code local configuration and other files what shall not belong to repository. See file itself for details. Feel free to extend it.

`lib` directory is structured to modules "style" to enable future expansion.

`config` directory contains database configuration.

`data` directory contains example csv files for students and courses import.

`db` directory contains database schema. **NB! do not commit created database file `fix_ois_example.sqlite3` to repository.

## Linter configuration

[RuboCop](https://rubocop.readthedocs.io/en/latest/) is used for static code analysis. Project contains `rubocop.yml` with recommended configuration. Feel free to extend it.

## Bundler

It is recommended to use [bundler](https://bundler.io) for projects gems management. 

**Please do not commit local bundler configuration `.bundle/config` to repository.**

Gems shall be installed locally to `vendor/bundle`:

```
$ bundler install --path vendor/bundle
```

**NB! Please install required Gems first before using rake or any other ruby program**

## Rake

[Rake - Ruby Make](https://ruby.github.io/rake/) is make-like build utility for Ruby.

Rake tasks are set up in `Rakefile` located in project root directory.

Following tasks are set up:

```
rake allTests       # Run rubocop and test tasks
rake clobber_rdoc   # Remove RDoc HTML files
rake db:create      # Create database and schema
rake db:dumpSchema  # Dump database schema
rake rdoc           # Build RDoc HTML files
rake rerdoc         # Rebuild RDoc HTML files
rake rubocop        # Run rubocop
rake test           # Run tests
```

Rake print all tasks usage:

```
$ bundle exec rake -T
```

Rake usage example to run linter and tests:

```
$ bundle exec rake
Running RuboCop...
Inspecting 9 files
.........

9 files inspected, no offenses detected
Run options: --seed 3485

# Running:

S..............

Finished in 0.002941s, 5100.3060 runs/s, 6460.3876 assertions/s.

15 runs, 19 assertions, 0 failures, 0 errors, 1 skips
```

## Active Record database management

Default database configuration is in `config/database.yml`

Temporary "In memory" database is created when running unit tests. See configuration file section `unit_test`.

Development [sqlite](https://www.sqlite.org) database shall be created and also recreated manually by running:

```
$ bundle exec rake db:create
```

Also schema can be dumped from database via rake when you want to make modifications and recreate your own database schema.