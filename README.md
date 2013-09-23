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

Any kind of contributions are EXTREMELY welcome, just drop me a line, open an issue, send a pidgeon
