# AssetSnack for Sinatra

A lean asset compiler for Sinatra developed specifically for Coffeescript and SASS. 
It stitches all assets for a route into a single file, no uglification, no minification (configure your server to use Gzip),
just lean, fast compilation.

[![Build Status](https://travis-ci.org/benkitzelman/sinatra-asset-snack.png?branch=master)](https://travis-ci.org/benkitzelman/sinatra-asset-snack)

## Installation
### Bundler users

If you use Bundler, add it to your *Gemfile.*

``` ruby
gem install sinatra-asset-snack
```


## Setup

Install the plugin configure your routes.

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

[sinatra]: http://sinatrarb.com
[coffee-script]: http://github.com/josh/ruby-coffee-script
[sass]: http://sass-lang.com/
