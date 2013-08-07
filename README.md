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

## Precompilation

Create a rake task. Make sure to first require the source file
containing your Sinatra application

For example, let's say you have a project called "idea" in which you
have a Sinatra::Base subclass called "Api", something like this:

#### idea/api.rb
```ruby
require 'sinatra/asset_snack'

module Idea
  class Api < Sinatra::Base
    register Sinatra::AssetSnack

    asset_map '/javascript/application.js', ['scripts/**/*.coffee']
    asset_map '/stylesheets/application.css', ['styles/**/*.scss']
  end
end
```

You may then set up your rake task to require that file, which will also
bring Sinatra::AssetSnack into scope, enabling this:

#### Rakefile
```ruby
namespace :assets do
  task :precompile do
    require 'idea/api' # Require your Sinatra app first
    print "Compiling assets ... "
    Sinatra::AssetSnack.precompile! # Now you can precompile
    puts "Done!"
  end
end
```

At this point you can execute `rake assets:precompile` to write the
compiled asset files to disk instead of the default dynamic
generation behavior of AssetSnack.
