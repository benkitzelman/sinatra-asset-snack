# AssetSnack for Sinatra

[![Build Status](https://travis-ci.org/benkitzelman/sinatra-asset-snack.png?branch=master)](https://travis-ci.org/benkitzelman/sinatra-asset-snack)
[![Gem Version](https://badge.fury.io/rb/sinatra-asset-snack.png)](http://badge.fury.io/rb/sinatra-asset-snack)
[![endorse](https://api.coderwall.com/benkitzelman/endorsecount.png)](https://coderwall.com/benkitzelman)

A lean asset compiler for Sinatra developed specifically for Coffeescript and SASS. 
It stitches all assets for a route into a single file, no uglification, no minification (configure your server to use Gzip),
just lean, fast compilation.

## Installation
### Bundler users

If you use Bundler, add it to your *Gemfile.*

``` ruby
gem install sinatra-asset-snack
```

## Setup

Require and register the gem then configure your routes.

``` ruby
require 'sinatra/asset_snack'

class App < Sinatra::Base
  register Sinatra::AssetSnack
  asset_map '/javascript/application.js', ['assets/js/**/*.js', 'assets/js/**/*.coffee']
  asset_map '/stylesheets/application.css', ['assets/stylesheets/**/*.css', 'assets/stylesheets/**/*.scss']
end
```

In your view / layout reference your assets using the relevant tag
```
<link rel="stylesheet" href="/stylesheets/application.css" type="text/css" />
<script src="/javascript/application.js" type="text/javascript"></script>
```

If you want - use the helpers to add cache busting
```
<link rel="stylesheet" href="<%= nocache '/stylesheets/application.css' %>" type="text/css" />
<script src="<%= nocache '/javascript/application.js' %>" type="text/javascript"></script>
```

## Configuring

Configuration options may be passed into each compiler. For example

``` ruby
Sinatra::AssetSnack.configuration.compilers[:coffee_script] = {bare: true}
Sinatra::AssetSnack.configuration.compilers[:sass] = {syntax: :scss}
```

See each compiler's repo for the list of configuration options


[sinatra](http://sinatrarb.com)

[coffee-script](http://github.com/josh/ruby-coffee-script)

[sass](http://sass-lang.com/)

## Precompile

To precompile your assets, you must set a constant `APP_FILE` to the
source file which defines your Sinatra app.

### Rakefile

```ruby
APP_FILE = "lib/app/app.rb"
require 'sinatra/asset_snack/rake'
```

This defines the rake task `assetsnack:build` which will precompile your
assets.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/benkitzelman/sinatra-asset-snack/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

