require 'test/unit'
require 'antiredundancy'

class MyDate
	include ::AntiRedundancy::ComparisonMethods

	attr_accessor :year
	attr_accessor :month
	attr_accessor :day	

	def initialize(y,m,d)
		@year = y
		@month = m
		@day = d
	end

	def <=>(other)
		hierarchical_comparison(other,[:year,:month,:day])
	end

end

class TestComparison < Test::Unit::TestCase

	def setup
		@d1 = MyDate.new 2000, 4, 27
	end

	def test_lower_year
		d2 = MyDate.new 1999, 4, 27
		assert_equal 1, @d1 <=> d2
	end

	def test_higher_year
		d2 = MyDate.new 2001, 4, 27
		assert_equal -1, @d1 <=> d2
	end

	def test_same_year_lower_month
		d2 = MyDate.new 2000, 3, 27
		assert_equal 1, @d1 <=> d2		
	end

	def test_same_year_higher_month
		d2 = MyDate.new 2000, 5, 27
		assert_equal -1, @d1 <=> d2		
	end

	def test_same_year_and_month_lower_day
		d2 = MyDate.new 2000, 4, 26
		assert_equal 1, @d1 <=> d2		
	end

	def test_same_year_and_month_higher_day
		d2 = MyDate.new 2000, 4, 28
		assert_equal -1, @d1 <=> d2		
	end

end