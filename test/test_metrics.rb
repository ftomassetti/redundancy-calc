require 'helper'

class TestMetrics < Test::Unit::TestCase

	include RedundancyCalc

	def test_calc_terms_map_redundancy_empty
		assert_equal 0.0, terms_map_redundancy({})
	end

	def test_calc_terms_map_redundancy_no_repetitions
		assert_equal 0.0, terms_map_redundancy({'abc'=>1,'def'=>1})
	end

	def test_calc_terms_map_redundancy_with_repetitions_1
		assert_equal 1, terms_map_redundancy({'abc'=>2,'def'=>1})
	end	

	def test_calc_terms_map_redundancy_with_repetitions_2
		assert_equal 2, terms_map_redundancy({'abc'=>3,'def'=>1})
	end		

	def test_calc_terms_map_redundancy_with_repetitions_3
		assert_in_delta 0.01, 4.472, terms_map_redundancy({'abc'=>3,'def'=>5})
	end		

	def test_calc_terms_map_density_of_redundancy_empty
		assert_equal 0.0, terms_map_density_of_redundancy({})
	end

	def test_calc_terms_map_density_of_redundancy_no_repetitions
		assert_equal 0.0, terms_map_density_of_redundancy({'abc'=>1,'def'=>1})
	end

	def test_calc_terms_map_density_of_redundancy_with_repetitions_1
		assert_in_delta 0.01, 0.5, terms_map_density_of_redundancy({'abc'=>2,'def'=>1})
	end	

	def test_calc_terms_map_density_of_redundancy_with_repetitions_2
		assert_in_delta 0.01, 0.66, terms_map_density_of_redundancy({'abc'=>3,'def'=>1})
	end		

	def test_calc_terms_map_density_of_redundancy_with_repetitions_3
		assert_in_delta 0.01, 0.64, terms_map_density_of_redundancy({'abc'=>3,'def'=>5})
	end			

end