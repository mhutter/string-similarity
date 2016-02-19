require 'spec_helper'

RSpec.describe String::SimilarityRefinements do
  using String::SimilarityRefinements

  it '#cosine_similarity_to calls the appropriate method' do
    expect(String::Similarity).to receive(:cosine).with('a', 'b')
    'a'.cosine_similarity_to('b')
  end

  it '#levenshtein_distance_to calls the appropriate method' do
    expect(String::Similarity).to receive(:levenshtein_distance).with('a', 'b')
    'a'.levenshtein_distance_to('b')
  end

  it '#levenshtein_similarity_to calls the appropriate method' do
    expect(String::Similarity).to receive(:levenshtein).with('a', 'b')
    'a'.levenshtein_similarity_to('b')
  end
end
