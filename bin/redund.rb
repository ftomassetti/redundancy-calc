#!/usr/bin/ruby

require 'commander/import'
require 'redundancy-calc'
require 'csv'

program :name, 'redund'
program :version, RedundancyCalc::VERSION
program :description, 'Calculate redundancy of code'

module RedundancyCalc

class RedundApp

def java_model_handler(node_type,methods)
    Proc.new do |f,m|
   #      code = IO.read(f)
   #      node_tree   = LightModels::Java.node_tree_from_code(code)
   #      corr_node_producer = Proc.new do |n,nt|
			# LightModels::Java.corresponding_node(n,nt)
   #      end
   #      lang_spec   = LightModels::Java::InfoExtraction::JavaSpecificInfoExtractionLogic.new
   #      node_writer = Proc.new do |corr_node|
			# corr_node.to_s
   #      end        
   #      m.children_deep.each do |node|
   #          if node and node.is_a?(node_type)
   #          	corr_node  = corr_node_producer.call(node,node_tree)
   #              redundancy,density = *calc_node_redundancy_and_density(node,lang_spec)
   #              raise "WRONG " unless redundancy
   #              raise "WRONG " unless density
   #              code = ""
   #              begin
   #                  code = node_writer.call(corr_node)
   #              rescue
   #                  warn "Problem getting code from: #{node.name}, #{$!}"
   #              end
   #              n_lines = code.count("\n")
   #              n_lines += 1 unless code[-1,1] == "\n"
   #              methods[proj_name] << {file:f, name:node.name, code:code, model:node,redundancy:redundancy,density:density,language: lang, nlines: n_lines}
   #          end
        end
end

def initialize(dir,node_type)
	# @methods = Hash.new do |h,k|
 #        h[k] = []
	# end
	# LightModels::Java.handle_models_in_dir(dir, model_handler(node_type,@methods))
	#LightModels::Ruby.handle_models_in_dir(src, model_handler(node_type,methods))
end

def csv
	# CSV do |csv|
 #        csv << %w{language file name redundancy density nlines code}
 #        @methods.each_with_index do |el,i|
 #            code = el[:code]
 #            code = code.gsub("\n","\\n")
 #            code = code.gsub("\r","\\r")
 #            csv << [el[:language],el[:file],el[:name],el[:redundancy],el[:density],el[:nlines],code]                        
 #        end
 #    end	
end

end # end of class

end # end of module

command :csv do |c|
  c.syntax = 'redund csv <node type> <code dir>'
  c.description = 'CSV with the redundancy of the code indicated'
  c.action do |args, options|
 #  	node_type_name = args[0]
 #  	raise "Unknown node type" unless const_defined?(node_type_name)
 #  	node_type = const_get(node_type_name)
	# dir = args[1]
	# if File.exist?(dir)
	# 	if File.directory?(dir)
	# 		app = RedundancyCalc::RedundApp.new(dir,node_type)
	# 		app.csv
	# 	else
	# 		say "Given path is not a dir"
	# 	end
	# else
	# 	say "Given dir do not exist"
	# end
  end
end