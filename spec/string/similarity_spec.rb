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

    context 'vector', :vector do
      it 'returns 1-gram vectors' do
        expect(klass.send(:vector, 'abacaba', 1))
          .to eq({
                   '[0, 0, "a"]' => 4,
                   '[0, 0, "b"]' => 2,
                   '[0, 0, "c"]' => 1
                 })
      end

      it 'returns 2-gram vectors' do
        expect(klass.send(:vector, 'abacaba', 2))
          .to eq({
                   '[1, 0, "a"]' => 1,
                   '[0, 0, "ab"]' => 2,
                   '[0, 0, "ba"]' => 2,
                   '[0, 0, "ac"]' => 1,
                   '[0, 0, "ca"]' => 1,
                   '[0, 1, "a"]' => 1
                 })
      end
    end

    context 'with n-grams' do
      it 'returns 1-gram similarity same as default' do
        s1 = klass.cosine('foo', 'boo')
        s2 = klass.cosine('foo', 'boo', ngram: 1)

        expect(s1).to eq s2
      end
      it 'returns correct 2-gram similarity' do
        # here _ is substitution for the pad symbol
        # abc has bigrams: _a, ab, bc, c_
        # abcacbc has bigrams: _a, ab, bc, ca, ac, cb, bc, c_

        expect(klass.cosine('abc', 'abcacbc',
                            ngram: 2)).to be_within(0.001).of(0.79)
      end

      it 'returns correct 3-gram similarity' do
        # here _ is substitution for the pad symbol
        # abc has bigrams: __a, _ab, abc, bc_, c__
        # abcacbc has bigrams: __a, _ab, abc, bca, cac, acb, cbc, bc_, c__

        expect(klass.cosine('abc', 'abcacbc',
                            ngram: 3)).to be_within(0.001).of(0.745)
      end

      it 'raises if n is < 1' do
        expect { klass.cosine('a', 'b',
                              ngrams: 0) }.to raise_error(ArgumentError)
      end
    end
  end

  context '#levenshtein_distance' do
    it 'returns 0 for identical strings' do
      expect(klass.levenshtein_distance('foo', 'foo')).to eq 0
      expect(klass.levenshtein_distance('', '')).to eq 0
    end

    it 'returns the other strings length if one string is empty' do
      expect(klass.levenshtein_distance('four', '')).to eq 4
      expect(klass.levenshtein_distance('', 'four')).to eq 4
    end

    it 'returns the correct distance' do
      # Wikipedia example
      expect(klass.levenshtein_distance('kitten', 'sitting')).to eq 3
      expect(klass.levenshtein_distance('sitting', 'kitten')).to eq 3
      expect(klass.levenshtein_distance('Saturday', 'Sunday')).to eq 3
      expect(klass.levenshtein_distance('Sunday', 'Saturday')).to eq 3
    end
  end

  context '#levenshtein' do
    it 'returns 1 for identical strings' do
      expect(klass.levenshtein('foo', 'foo')).to eq 1.0
      expect(klass.levenshtein('', '')).to eq 1.0
    end

    it 'returns 0 if one string is empty' do
      expect(klass.levenshtein('', 'foo')).to eq 0.0
      expect(klass.levenshtein('foo', '')).to eq 0.0
    end

    it 'returns the inverse of the levenshtein distance' do
      expect(klass.levenshtein('kitten', 'sitting')).to eq (1.0/3)
      expect(klass.levenshtein('foo', 'far')).to eq 0.5
    end
  end
end
