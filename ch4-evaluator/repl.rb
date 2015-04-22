#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

load "parser.rb"
load "type.rb"
#load "evaluator.rb"

class REPLServer
  @@in_prompt = '> '
  @@out_prompt = '=> '

  def initialize()
  end

  def run()
    while true
      print @@in_prompt

      input = read_line()
      if input == "quit\n"
        return "good bye!!"
      end
      
      begin
        tokens = Parser.tokenize(input)
        nodes = Parser.parse(tokens)
#        output = nodes

        exp = Translator.do(nodes)
        output = exp
        
#        output = @evaluator.eval(nodes, @environment)
        
      rescue Exception => e
        p e.to_s
        redo
      end

      print @@out_prompt
      p output
    end
  end

  private
  def read_line()
    input = gets or return
    while (count = input.count('(') -input.count(')')) > 0
      print "  " * (1 + count)
      next_input = gets or return
      input += next_input
    end

    input
  end
end