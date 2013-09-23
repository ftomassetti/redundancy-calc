#!/usr/bin/ruby

require 'commander/import'
require 'redundancy-calc'
require 'java-lightmodels'
require 'ruby-lightmodels'
require 'csv'

#LightModels::ModelBuilding.verbose = true

program :name, 'redund'
program :version, RedundancyCalc::VERSION
program :description, 'Calculate redundancy of code'

class RedundApp

include RedundancyCalc

def common_model_handler(code,node_tree,corr_node_producer,lang_spec,node_writer,f,m,methods,node_type,lang)
   	m.children_deep.each do |node|
		if node and node.is_a?(node_type)
        	corr_node  = corr_node_producer.call(node,node_tree)
            redundancy,density = *calc_node_redundancy_and_density(node)
            raise "WRONG " unless redundancy
            raise "WRONG " unless density
            code = ""
            begin
                code = node_writer.call(corr_node)
            rescue
                warn "Problem getting code from: #{node.name}, #{$!}"
            end
            n_lines = code.count("\n")
            n_lines += 1 unless code[-1,1] == "\n"
            node_name = ""
            node_name = node.name if node.respond_to?(:name)
            methods << {file:f, lang:lang, name:node_name, code:code, model:node,redundancy:redundancy,density:density,nlines: n_lines}
			end
	end
end

def java_model_handler(node_type,methods)
    Proc.new do |f,m|
        code = IO.read(f)
        node_tree   = LightModels::Java.node_tree_from_code(code)
        corr_node_producer = Proc.new do |n,nt|
			LightModels::Java.corresponding_node(n,nt)
        end
        lang_spec   = LightModels::Java::InfoExtraction::JavaSpecificInfoExtractionLogic.new
        node_writer = Proc.new do |corr_node|
			corr_node.to_s
        end        
        common_model_handler(code,node_tree,corr_node_producer,lang_spec,node_writer,f,m,methods,node_type,'java')
    end
end

def ruby_model_handler(node_type,methods)
    Proc.new do |f,m|
        code = IO.read(f)
        node_tree   = LightModels::Ruby.node_tree_from_code(code)
        corr_node_producer = Proc.new do |n,nt|
            n.original_node
        end
        lang_spec   = LightModels::Ruby::InfoExtraction::RubySpecificInfoExtractionLogic.new
        node_writer = Proc.new do |corr_node|
            return "" unless corr_node
            sw = java.io.StringWriter.new
            rwv = org.jrubyparser.rewriter.ReWriteVisitor.new(sw,'')
            cbw = org.jrubyparser.rewriter.ClassBodyWriter.new(rwv,corr_node)
            cbw.write
            sw.to_string
        end
        common_model_handler(code,node_tree,corr_node_producer,lang_spec,node_writer,f,m,methods,node_type,'ruby')
    end
end

def initialize(dir,node_type)
	@methods = []
	LightModels::Java.handle_models_in_dir(dir, java_model_handler(node_type,@methods))
	LightModels::Ruby.handle_models_in_dir(dir, ruby_model_handler(node_type,@methods))
end

def csv
	CSV do |csv|
        csv << %w{language file name redundancy density nlines code}
        @methods.each_with_index do |el,i|
            code = el[:code]
            code = code.gsub("\n","\\n")
            code = code.gsub("\r","\\r")
            csv << [el[:lang],el[:file],el[:name],el[:redundancy],el[:density],el[:nlines],code]                        
        end
    end	
end

end # end of class

def java_valid_types
	types = LightModels::Java.constants.select do |cn| 
		c = LightModels::Java.const_get(cn)
		c.is_a?(Class)
	end.sort
end

def ruby_valid_types
	types = LightModels::Ruby.constants.select do |cn| 
		c = LightModels::Ruby.const_get(cn)
		c.is_a?(Class)
	end.sort
end

command :csv do |c|
  c.syntax = 'redund csv <node type> <code dir>'
  c.description = 'CSV with the redundancy of the code indicated'
  c.action do |args, options|
  	if args.count<2
  		warn "specify node type and directory"
  		return
  	end
  	node_type_name = args[0]
  	begin
  		node_type = LightModels::Java.const_get(node_type_name) if LightModels::Java.const_defined?(node_type_name)
  		node_type = LightModels::Ruby.const_get(node_type_name) if LightModels::Ruby.const_defined?(node_type_name)
  	rescue NameError
  		# ok, unvalid name, treat it as name of unexisting Const
  	end
  	unless node_type
  		warn "Unknown node type '#{node_type_name}'" 
  		warn "Valid Java types are:"
  		java_valid_types.each {|t| warn " * #{t}"}
  		warn "Valid Ruby types are:"
  		ruby_valid_types.each {|t| warn " * #{t}"}  		
  	else
		dir = args[1]
    warn "Using dir '#{dir}'"
		if File.exist?(dir)
			if File.directory?(dir)
				app = RedundApp.new(dir,node_type)
				app.csv
			else
				say "Given path is not a dir"
			end
		else
			say "Given dir do not exist"
		end
	end
  end
end