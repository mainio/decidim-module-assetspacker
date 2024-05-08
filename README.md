# Decidim::Assetspacker

> [!NOTE]
> This module is currently under development. You should take it as an
> experimental R&D project. The purpose of the module is to analyze Decidim's
> asset packing process and trying to identify bottlenecks and places for
> performance improvements by dropping all unnecessary parts away from the build
> process and by utilizing a significantly faster build tool than Webpack.

This module modifies the asset building process in Decidim and utilizes ESBuild
instead of Webpack for maximum performance.

The asset building process has been modified with the following changes:

- Use ESBuild instead of Webpack
- Drop SCSS out of the equation and replace it with a combination of PostCSS
  plugins
- Optimize the asset building process as far as possible now that we can control
  every aspect of it

This has lead to the initial/first build time drops to about 25% of the time
utilized by Webpack (i.e. 4 times faster initial build).

There have been the following findings during the creation of this tool:

- Tailwind is the biggest bottleneck of the asset building tool and particularly
  the `@apply` rules used within Decidim's CSS. We have tried to implement the
  suggestions from the related GitHub issues with no visible performance boost.
- Dropping Tailwind completely would cause the asset building performance to be
  lightyears faster. Compiling the Tailbloat stuff takes around 75% of the
  current build time.
- By dropping all the `@apply` rules, we could achieve around 2x the current
  performance. This has been tested by modifying the Tailwind PostCSS plugin by
  hand and removing the processing of the `@apply` rules.
- The rebuild times are not significantly faster with ESBuild compared to
  Webpack. The main difference can be seen in the initial build time which is an
  indication that the Webpack initialization process carries a lot of
  unnecessary extra weight.
- By dropping the SCSS compiler out of the equation we can achieve very minimal
  performance improvements, most of the build time is wasted on Tailbloat. The
  Dart Sass implementation is already highly optimized unlike Tailbloat.

## Installation

Add this line to your application's Gemfile:

```ruby
# Keep this below all other Decidim gem for it to override some entrypoints.
gem "decidim-assetspacker", github: "mainio/decidim-module-assetspacker", branch: "main"
```

And then execute:

```bash
$ bundle
$ npm i -D postcss-nesting postcss-partial-import postcss-simple-vars postcss-strip-inline-comments
```

## Usage

Note that Decidim's default SCSS files are currently not compatible with this
module because the SCSS complier has been dropped. Therefore, for the time
being, you can use our custom fork that modifies the files to be supported by
this tool. The fork can be found from this branch:

https://github.com/mainio/decidim/tree/feature/postcss-only

Once installed using this core fork, you can execute the `decidimpack` command
via bundle exec as follows:

```bash
$ bundle exec decidimpack
```

The following flags are available for the command:

- `-w` - Will run the file watcher so that rebuilds happen automatically when
  JS or (S)CSS files are changed.
- `-s` - Will run an HTTP server that will allow the browser to reload the page
  automatically after re-building the assets. Needs to be run together with the
  `-w` flag.

### Alternative approach for comparison (SCSS building)

There is also an alternative implementation of this tool that uses the
`esbuild-sass-plugin` and is more compatible with the current SCSS files shipped
within Decidim. This alternative implementation is fully integrated into Decidim
and does not require installing this gem. The alternative can be found from this
branch:

https://github.com/mainio/decidim/tree/feature/esbuild-assets-performance

## Contributing

See [Decidim](https://github.com/decidim/decidim).

### Developing

To start contributing to this project, first:

- Install the basic dependencies (such as Ruby and PostgreSQL)
- Clone this repository

Decidim's main repository also provides a Docker configuration file if you
prefer to use Docker instead of installing the dependencies locally on your
machine.

You can create the development app by running the following commands after
cloning this project:

```bash
$ bundle
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rake development_app
```

Note that the database user has to have rights to create and drop a database in
order to create the dummy test app database.

Then to test how the module works in Decidim, start the development server:

```bash
$ cd development_app
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rails s
```

In case you are using [rbenv](https://github.com/rbenv/rbenv) and have the
[rbenv-vars](https://github.com/rbenv/rbenv-vars) plugin installed for it, you
can add the environment variables to the root directory of the project in a file
named `.rbenv-vars`. If these are defined for the environment, you can omit
defining these in the commands shown above.

#### Code Styling

Please follow the code styling defined by the different linters that ensure we
are all talking with the same language collaborating on the same project. This
project is set to follow the same rules that Decidim itself follows.

[Rubocop](https://rubocop.readthedocs.io/) linter is used for the Ruby language.

You can run the code styling checks by running the following commands from the
console:

```
$ bundle exec rubocop
```

To ease up following the style guide, you should install the plugin to your
favorite editor, such as:

- Sublime Text - [Sublime RuboCop](https://github.com/pderichs/sublime_rubocop)
- Visual Studio Code - [Rubocop for Visual Studio Code](https://github.com/misogi/vscode-ruby-rubocop)

### Testing

To run the tests run the following in the gem development path:

```bash
$ bundle
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rake test_app
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rspec
```

Note that the database user has to have rights to create and drop a database in
order to create the dummy test app database.

In case you are using [rbenv](https://github.com/rbenv/rbenv) and have the
[rbenv-vars](https://github.com/rbenv/rbenv-vars) plugin installed for it, you
can add these environment variables to the root directory of the project in a
file named `.rbenv-vars`. In this case, you can omit defining these in the
commands shown above.

### Test code coverage

If you want to generate the code coverage report for the tests, you can use
the `SIMPLECOV=1` environment variable in the rspec command as follows:

```bash
$ SIMPLECOV=1 bundle exec rspec
```

This will generate a folder named `coverage` in the project root which contains
the code coverage report.

## License

See [LICENSE-AGPLv3.txt](LICENSE-AGPLv3.txt).
