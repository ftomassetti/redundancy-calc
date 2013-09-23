# Redundancy-calc

This project contains utilities to evaluate redundancy

NOTE: JRuby is required because some of the parser used are Java libraries.

## Installation using gem

Add this line to your application's Gemfile:

    gem 'redundancy-calc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install antiredundancy

## Installation from source

Or get the source and run
	
	rake build install

## Usage

Example:

redund csv ClassMethodDeclaration some-dir

will print out a csv file with all the information for nodes of Java class methods contained in the given dir

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
