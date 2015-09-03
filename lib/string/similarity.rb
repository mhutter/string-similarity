require 'string/similarity/version'

class String

  def cosine_similarity_to(other)
    String::Similarity.cosine(self, other)
  end

  # +String::Similarity+ provides various methods for
  # calculating string distances.
  module Similarity extend self


    # Calcuate the
    # {https://en.wikipedia.org/wiki/Cosine_similarity Cosine similarity}
    # of two strings.
    #
    # @param str1 [String] first string
    # @param str2 [String] second string
    # @return [Float] cosine distance of the two arguments.
    #   - +1.0+ if the strings are identical
    #   - +0.0+ if the strings are completely different
    #   - +0.0+ if one of the strings is empty
    def cosine(str1, str2)
      return 1.0 if str1 == str2
      return 0.0 if str1.empty? || str2.empty?

      # convert both texts to vectors
      v1, v2 = vector(str1), vector(str2)

      # calculate the dot product
      dot_product = dot(v1, v2)

      # calculate the magnitude
      magnitude = mag(v1.values) * mag(v2.values)
      dot_product / magnitude
    end

    private

    # create a vector from +str+
    #
    # @example
    #     vector('hello') # => {"h"=>1, "e"=>1, "l"=>2, "o"=>1}
    def vector(str)
      v = Hash.new(0)
      str.each_char { |c| v[c] += 1 }
      v
    end

    # calculate the dot product of +vector1+ and +vector2+
    def dot(vector1, vector2)
      product = 0
      vector1.each do |k,v|
        product += v * vector2[k]
      end
      product
    end

    # calculate the magnitude for +vector+
    def mag(vector)
      # calculate the sum of squares
      sq = vector.inject(0) { |s,n| s + n**2 }
      Math.sqrt(sq)
    end
  end
end
