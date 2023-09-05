# Enumberable

#my_each, my_select, my_reject, my_any? / my_all?, my_flatten, my_zip, my_rotate, my_join, my_reverse

class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        new_array = []

        self.my_each { |ele| new_array << ele if prc.call(ele) }

        new_array
    end

    def my_reject(&prc)
        new_array = []

        self.my_each { |ele| new_array << ele if !prc.call(ele) }

        new_array
    end

    def my_any?(&prc)
        self.my_each { |ele| return true if prc.call(ele) }
        false
    end

    def my_all?(&prc)
        self.my_each { |ele| return false if !prc.call(ele) }
        true
    end

    def my_flatten
        return self[0] if self.length == 1

        result = []

        self.each do |ele|
            if ele.is_a?(Array)
                result += ele.my_flatten
            else
                result << ele
            end
        end

        result
    end

    def my_zip(*args)
        new_array = Array.new(self.length) { Array.new }

        (0...self.length).each do |i|
            new_array[i] << self[i]
            args.my_each do |arg|
                new_array[i] << arg[i]
            end
        end

        new_array
    end

    def my_rotate(num = 1)
        new_array = []

        self.my_each { |ele| new_array << ele }
        
        if num > 0
            num.times { new_array.push(new_array.shift) }
        else
            (-num).times { new_array.unshift(new_array.pop) }
        end

        new_array
    end

    def my_join(separator = "")
        combined = ""

        self.each_with_index do |ele, idx|
            if idx != self.length - 1
                combined += ele + separator
            else
                combined += ele
            end
        end

        combined
    end

    def my_reverse
        return self if self.length == 1

        self[1..-1].my_reverse + [self[0]]
    end
end

return_value = [1, 2, 3].my_each do |num|
 puts num
end.my_each do |num|
 puts num
end
# => 1
#    2
#    3
#    1
#    2
#    3

p return_value  # => [1, 2, 3]

a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]

def factors(num)
    factors = []

    (1...num).each { |factor| factors << factor if num % factor == 0 }

    factors
end

p factors(24)
p factors(12)
p factors(60)

class Array
    def bubble_sort!(&prc)
        sorted = false

        while !sorted
            sorted = true

            (0...self.length - 1).each do |i|
                if prc.call(self[i], self[i + 1]) == 1
                    self[i], self[i + 1] = self[i + 1], self[i]
                    sorted = false
                end
            end
        end

        self
    end

    def bubble_sort(&prc)
        new_array = self.clone

        sorted = false

        while !sorted
            sorted = true

            (0...new_array.length - 1).each do |i|
                if prc.call(new_array[i], new_array[i + 1]) == 1
                    new_array[i], new_array[i + 1] = new_array[i + 1], new_array[i]
                    sorted = false
                end
            end
        end

        new_array
    end
end

alpha = [3,2,1]
p alpha.bubble_sort! { |a, b| a <=> b }
p alpha 

beta = [4,3,2,1]
p beta.bubble_sort { |a, b| a <=> b }
p beta

def substrings(string)
    substrings = []

    (0...string.length).each do |start|
        (start...string.length).each do |finish|
            substrings << string[start..finish]
        end
    end

    substrings
end

puts substrings("apple")
puts substrings("scar")
puts substrings("scared")

def subwords(word, dictionary)
    substrings = substrings(word)
    subwords = []

    IO.foreach(dictionary) { |word| subwords << word.downcase if substrings.include?(word.downcase.chomp)}

    subwords
end

puts subwords("apple", "01 dictionary")