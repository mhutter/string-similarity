require 'string/similarity/version'

# For convenience, String is extended by a couple of helper methods
class String
  # Returns the cosine similarity to +other+
  # @see String::Similarity#cosine
  def cosine_similarity_to(other)
    String::Similarity.cosine(self, other)
  end

  # Returns the Levenshtein distance to +other+
  # @see String::Similarity.levenshtein_distance
  def levenshtein_distance_to(other)
    String::Similarity.levenshtein_distance(self, other)
  end

  # Returns the Levenshtein similarity to +other+
  # @see String::Similarity.levenshtein
  def levenshtein_similarity_to(other)
    String::Similarity.levenshtein(self, other)
  end

  # +String::Similarity+ provides various methods for
  # calculating string distances.
  module Similarity
    # Calcuate the {https://en.wikipedia.org/wiki/Cosine_similarity
    # Cosine similarity} of two strings.
    #
    # For an explanation of the Cosine similarity of two strings read
    # {http://stackoverflow.com/a/1750187/405454 this excellent SO answer}.
    #
    # @param str1 [String] first string
    # @param str2 [String] second string
    # @return [Float] cosine similarity of the two arguments.
    #   - +1.0+ if the strings are identical
    #   - +0.0+ if the strings are completely different
    #   - +0.0+ if one of the strings is empty
    def self.cosine(str1, str2)
      return 1.0 if str1 == str2
      return 0.0 if str1.empty? || str2.empty?

      # convert both texts to vectors
      v1 = vector(str1)
      v2 = vector(str2)

      # calculate the dot product
      dot_product = dot(v1, v2)

      # calculate the magnitude
      magnitude = mag(v1.values) * mag(v2.values)
      dot_product / magnitude
    end

    # Calculate the Levenshtein similarity for two strings.
    #
    # This is basically the inversion of the levenshtein_distance, i.e.
    #     1 / levenshtein_distance(str1, str2)
    #
    # @param str1 [String] first string
    # @param str2 [String] second string
    # @return [Float] levenshtein similarity of the two arguments.
    #   - +1.0+ if the strings are identical
    #   - +0.0+ if one of the strings is empty
    # @see #levenshtein_distance
    def self.levenshtein(str1, str2)
      return 1.0 if str1.eql?(str2)
      return 0.0 if str1.empty? || str2.empty?
      1.0 / levenshtein_distance(str1, str2)
    end

    # Calculate the {https://en.wikipedia.org/wiki/Levenshtein_distance
    # Levenshtein distance} of two strings.
    #
    # @param str1 [String] first string
    # @param str2 [String] second string
    # @return [Fixnum] edit distance between the two strings
    #   - +0+ if the strings are identical
    def self.levenshtein_distance(str1, str2)
      # base cases
      result = base_case?(str1, str2)
      return result if result

      # Initialize cost-matrix rows
      previous = (0..str2.length).to_a
      current = []

      (0...str1.length).each do |i|
        # first element is always the edit distance from an empty string.
        current[0] = i + 1
        (0...str2.length).each do |j|
          current[j + 1] = [
            # insertion
            current[j] + 1,
            # deletion
            previous[j + 1] + 1,
            # substitution or no operation
            previous[j] + (str1[i].eql?(str2[j]) ? 0 : 1)
          ].min
        end
        previous = current.dup
      end

      current[str2.length]
    end

    private

    def self.base_case?(str1, str2)
      return 0 if str1.eql?(str2)
      return str2.length if str1.empty?
      return str1.length if str2.empty?
      false
    end

    # create a vector from +str+
    #
    # @example
    #     v1 = vector('hello') # => {"h"=>1, "e"=>1, "l"=>2, "o"=>1}
    #     v1["x"] # => 0
    def self.vector(str)
      v = Hash.new(0)
      str.each_char { |c| v[c] += 1 }
      v
    end

    # calculate the dot product of +vector1+ and +vector2+
    def self.dot(vector1, vector2)
      product = 0
      vector1.each do |k, v|
        product += v * vector2[k]
      end
      product
    end

    # calculate the magnitude for +vector+
    def self.mag(vector)
      # calculate the sum of squares
      sq = vector.inject(0) { |a, e| a + e**2 }
      Math.sqrt(sq)
    end
  end
end
