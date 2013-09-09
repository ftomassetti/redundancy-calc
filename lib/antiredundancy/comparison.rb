module AntiRedundancy

module ComparisonMethods

def hierarchical_comparison(other, fields)
	fields.each do |field|
		my_value    = self.send  field
		other_value = other.send field
		cmp = my_value <=> other_value
		return (my_value ? -1 : 1) unless cmp			
		return cmp                 unless cmp==0
	end
	return 0
end

end

end