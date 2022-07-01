require_relative "../mytests.rb"

test_score = MyTests::TestScore.new
suite = MyTests::Suite.new test_score

def sum(*args)
    args.reduce(:+)
end

suite.myit "should sum two values" do
    suite.expect(sum(1, 2)).to_equals(3)
end

suite.myit "should sum tree values" do
    suite.expect(sum(1, 2, 3)).to_equals(6)
end

suite.myit "should sum four values" do
    suite.expect(sum(1, 2, 3, 5)).to_equals(11)
    suite.expect(sum(-1, -2, -3, -5)).to_equals(-11)
end

suite.myit "should sum four values (2)" do
    suite.expect(sum(1, 2, 3, 5)).to_equals(12)
end

suite.myit "should has key (1)" do
    suite.expect({name: "Jeferson"}).has_key("name")
end

suite.myit "should has key (2)" do
    suite.expect({name: "Jeferson"}).has_key("any")
end

suite.myit "should has key (3)" do
    suite.expect(5).has_key("any")
end

puts "\nASSERTIONS"
puts "Total: #{test_score.count_total}"
puts "Rights: #{test_score.count_rights}"
puts "Wrong: #{test_score.count_wrong}"