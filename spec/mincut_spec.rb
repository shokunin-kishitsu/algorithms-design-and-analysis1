require 'spec_helper.rb'

describe Mincut do
  it 'test the test' do
    results = []
    (200**2).times do |i|
      results << Mincut::Runner.run
      puts results.min
    end
    expect(1).to be 1
  end
end