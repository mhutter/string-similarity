require 'spec_helper'

RSpec.describe String do
  it 'does not pollute the main namespace' do
    expect('string').to_not respond_to :levenshtein_similarity_to
  end
end
