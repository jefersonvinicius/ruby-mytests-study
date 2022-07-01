require 'colorize'

module MyTests
    class ExpectationError < StandardError
    end

    class Expectation 
        attr_reader :is_asserted, :is_right

        def initialize(actual:)
            @actual = actual
            @is_asserted = false
            @is_right = nil
        end

        def to_equals(expected)
            @is_asserted = true
            if @actual != expected
                @is_right = false;    
                raise ExpectationError.new("Expected #{expected}, but got #{@actual}")
            end
            @is_right = true;
        end

        def has_key(key)
            if !defined?(@actual.has_key?) || !@actual.has_key?(key.to_sym)
                @is_right = false;    
                raise ExpectationError.new("Expected #{@actual} has key '#{key}'")
            end
            @is_right = true;
        end
    end

    class TestScore 

        def initialize()
            @expectations = []
        end

        def rights
            @expectations.select { |expc| expc.is_asserted && expc.is_right == true }
        end

        def wrongs
            @expectations.select { |expc| expc.is_asserted && expc.is_right == false }
        end

        def count_rights
            rights.length
        end

        def count_wrong
            wrongs.length
        end

        def count_total
            count_wrong + count_rights
        end

        def add_expectation(expectation)
            @expectations.push(expectation)
        end
    end

    class Suite 
        
        def initialize(test_score)
            @test_score = test_score
        end

        def expect(result)
            expectation = Expectation.new actual: result
            @test_score.add_expectation(expectation)
            return expectation
        end

        def myit(text, &block)
            begin
                yield
                puts "#{text} - OK!".green
            rescue ExpectationError => err
                puts "#{text} - FAIL!".red
                puts "  * #{err.message}".red
            end
        end
    end
end

