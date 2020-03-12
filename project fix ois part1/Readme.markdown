# ICS0013 2019 spring semester lab2 project template

## Project structure and files

Structure is inline with [RubyGems basics guide](https://guides.rubygems.org/rubygems-basics/) freewill example and [Learn Ruby the hard way Exercise 46: A Project Skeleton](https://learnrubythehardway.org/book/ex46.html) as far as applicable. Directories contain `.gitkeep` because Git does not track empty directories.

`.gitignore` contains common operating systems and ruby projects ignored files from [GitHub templates](https://github.com/github/gitignore). It is extended to ignore gitlab-runner builds, VS Code local configuration and other files what shall not belong to repository. See file itself for details. Feel free to extend it.

`lib` directory is structured to modules "style" to enable future expansion.

## Linter configuration

[RuboCop](https://rubocop.readthedocs.io/en/latest/) is used for static code analysis. Project contains `rubocop.yml` with recommended configuration. Feel free to extend it.

## Rake

[Rake - Ruby Make](https://ruby.github.io/rake/) is make-like build utility for Ruby.

Rake tasks are set up in `Rakefile` located in project root directory.

Following tasks are set up:

- `rubocop` - runs rubocop task for all files located in `lib` and `tests`.
- `test` - runs test tasks for all test files in directory `test`.
- `all` - runs all tasks mentioned above. This is also default target.

Usage example:

```
$ rake
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