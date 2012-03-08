# gestopft

![Dependency Status](https://gemnasium.com/aereal/gestopft.png)
![Build Status](https://secure.travis-ci.org/aereal/gestopft.png)

## Description

Framework for CLI Application (like [App::CLI](http://search.cpan.org/dist/App-CLI/))


## Installation

### Archive

```
bundle install
bundle exec rake install
```

### Gem

```
gem install gestopft
```


## Synopsis

``` ruby
require "gestopft"

class Echo < Gestopft::App
  option :verbose, "print debug messages."

  def echo(message)
    puts "Echo#echo is invoked." if @options[:verbose]
    puts message
  end
end
```


## Copyright

Copyright:: Copyright (c) 2011-2012 aereal
Author::    aereal (trasty.loose@gmail.com)
License::   Ruby's

