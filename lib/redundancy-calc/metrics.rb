require 'lightmodels'

module RedundancyCalc

def terms_map_redundancy(terms_map)
        redundancy = 0
        terms_map.each do |t,c|
                redundancy += (c-1.0).to_f**2.0
        end
        redundancy = Math.sqrt(redundancy)
        redundancy
end

def terms_map_density_of_redundancy(terms_map)
        total = 0
        terms_map.each {|t,c| total+=c}

        return 0.0 if total==1

        terms_map_redundancy(terms_map)/(total.to_f-1.0).to_f
end

def calc_node_redundancy_and_density(node,language_info_logic)
        terms_map = LightModels::InfoExtraction.terms_map(language_info_logic,node)
        [terms_map_redundancy(terms_map),terms_map_density_of_redundancy(terms_map)]
end

end
