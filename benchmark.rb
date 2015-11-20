require 'benchmark/ips'

User = Struct.new(:id, :stuff)
a = Array.new(1000) { |i| User.new(i, stuff: rand(1000)) }

10.times do
  Benchmark.ips do |x|
    x.report('#inject return') do
      a.inject({}) { |memo, i| memo[i.id] = i.stuff; memo }
    end
    x.report('merge') do
      a.inject({}) { |memo, i| memo.merge(i.id => i.stuff) }
    end
    x.report('merge!') do
      a.inject({}) { |memo, i| memo.merge!(i.id => i.stuff) }
    end
    x.report('each_with_object') do
      a.each_with_object({}) { |i, memo| memo[i.id] = i.stuff }
    end

    x.report('zenspider') do
      Hash[a.map(&:to_a)]
    end

    x.report('pipework') do
      a.map(&:to_a).to_h
    end

    x.compare!
  end
end