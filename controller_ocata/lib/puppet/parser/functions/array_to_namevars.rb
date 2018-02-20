#!/usr/bin/env ruby
# encoding: utf-8

module Puppet::Parser::Functions

  newfunction(:array_to_namevars, :type => :rvalue) do |args|
    values = args[0]
    prefix = args[1]
    sep = args[2] || ":"

    idx = 0
    ret = Array(values).collect { |v|
      idx = idx + 1

      "#{prefix}#{sep}#{idx}#{sep}#{v}"
    }
    return ret
  end
end
