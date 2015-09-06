require 'string/similarity/version'

class String
  # Returns the cosine similarity to `other`
  # @see String::Similarity#cosine
  def cosine_similarity_to(other)
    String::Similarity.cosine(self, other)
  end

  # Returns the Levenshtein distance to `other`
  # @see String::Similarity.levenshtein_distance
  def levenshtein_distance_to(other)
    String::Similarity.levenshtein_distance(self, other)
  end

  # +String::Similarity+ provides various methods for
  # calculating string distances.
  module Similarity extend self
    # Calcuate the
    # {https://en.wikipedia.org/wiki/Cosine_similarity Cosine similarity}
    # of two strings.
    #
    # For an explanation of the Cosine similarity of two strings read
    # {http://stackoverflow.com/a/1750187/405454 this excellent SO answer}.
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

    # Calculate the {https://en.wikipedia.org/wiki/Levenshtein_distance
    # Levenshtein distance} of two strings.
    def levenshtein_distance(str1, str2)
      return 0 if str1.eql?(str2)
      return str2.length if str1.empty?
      return str1.length if str2.empty?

      # Initialize cost-matrix. str1 is X, str2 is Y
      matrix = Array.new(str2.length + 1) { Array.new(str1.length + 1) }

      # prepopulate zero-length edit distances
      (str2.length + 1).times { |i| matrix[i][0] = i }
      (str1.length + 1).times { |i| matrix[0][i] = i }

      fill_cost_matrix(matrix, str1, str2)

      # result is in the last cell
      matrix[str2.length][str1.length]
    end

    private

    # Fill in `matrix` with the edit distances needed for the Levenshtein
    # distance
    def fill_cost_matrix(matrix, str1, str2)
      (1..str2.length).each do |x|
        (1..str1.length).each do |y|
          if str2[x-1] == str1[y-1]
            # no operation required
            matrix[x][y] = matrix[x-1][y-1]
          else
            matrix[x][y] = min_edit_distance(matrix, x, y)
          end
        end
      end
      matrix
    end

    # get the minimum edit distance for `matrix[x][y]`
    def min_edit_distance(matrix, x, y)
      [
        matrix[x-1][ y ] + 1, # deletion
        matrix[ x ][y-1] + 1, # insertion
        matrix[x-1][y-1] + 1, # subsitution
      ].min
    end

    # create a vector from +str+
    #
    # @example
    #     v1 = vector('hello') # => {"h"=>1, "e"=>1, "l"=>2, "o"=>1}
    #     v1["x"] # => 0
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
