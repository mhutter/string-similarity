require 'spec_helper'

RSpec.describe String::Similarity do
  let(:klass) { ::String::Similarity }

  it 'has a version' do
    expect(klass::VERSION).to_not be_nil
  end

  context '#cosine' do
    it 'returns 1.0 for identical strings' do
      expect(klass.cosine('foo', 'foo')).to eq 1.0
      expect(klass.cosine('', '')).to eq 1.0
    end

    it 'returns 0.0 if one string is empty' do
      expect(klass.cosine('foo', '')).to eq 0.0
      expect(klass.cosine('', 'foo')).to eq 0.0
    end

    it 'returns 0.0 for completely different strings' do
      expect(klass.cosine('foo', 'bar')).to eq 0.0
    end

    it 'calculates the appropriate similarity' do
      s1, s2 = klass.cosine('foo', 'boo'), klass.cosine('foo', 'qoo')
      expect(s1).to eq s2
      expect(klass.cosine('JlmotLlm', 'JimotJlm')).to be_within(0.001).of(0.833)
    end

    it 'returns values <= 1.0' do
      expect(klass.cosine('foo', 'fooaf')).to be <= 1.00000
    end
  end
end

RSpec.describe String do
  context '#cosine_similarity_to' do
    it 'calls the appropriate method' do
      expect(String::Similarity).to receive(:cosine).with('this', 'other')
      'this'.cosine_similarity_to('other')
    end
  end
end
