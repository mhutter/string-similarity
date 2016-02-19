# provide refinements for the String class
module String::SimilarityRefinements
  refine String do
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
  end
end
