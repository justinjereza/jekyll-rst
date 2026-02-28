# frozen_string_literal: true

require "rbst"

module Jekyll
  module Rst
    class Error < StandardError; end
  end

  module Converters
    class Rest < Converter
      safe true
      priority :low

      def matches(ext)
        ext =~ /^\.rst$/i
      end

      def output_ext(ext)
        ".html"
      end

      def convert(content)
        RbST.new(content).to_html(initial_header_level: 2, syntax_highlight: "short")
      end
    end
  end

  module Rst
    module Filters
      def restify(input)
        @context.registers[:site].find_converter_instance(
          Jekyll::Converters::Rest
        ).convert(input.to_s)
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::Rst::Filters)
