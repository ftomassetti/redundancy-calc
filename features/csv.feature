Feature: We can get a CSV file with the redundancy of nodes
	I want to get a CSV file with redundancy of nodes
	to analyze them

Scenario: Generate a CSV file with the redundancy of Ruby methods
	Given the file data/example.rb exists
	When I run `redund csv Def data > out.csv`
	Then a file named out.csv is created
	And the file out.csv contains the redundancy of all the methods of example.rb