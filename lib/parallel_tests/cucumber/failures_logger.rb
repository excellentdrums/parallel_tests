require 'cucumber/formatter/rerun'
require 'parallel_tests/gherkin/io'

module ParallelTests
  module Cucumber
    class FailuresLogger < ::Cucumber::Formatter::Rerun
      include ParallelTests::Gherkin::Io

      def initialize(runtime, path_or_io, options)
        @io = prepare_io(path_or_io)
        @failures = {}
      end

      def after_feature(feature)
        unless @failures.empty?
          lock_output do
            @failures.each do |failure|
              @io.puts "#{feature.file}:#{failure}"
            end
          end
        end
      end

    end
  end
end
