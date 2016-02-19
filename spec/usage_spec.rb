require 'spec_helper'

RSpec.describe 'loading' do

  it 'can be required with string/similarity' do
    expect {
      require 'string/similarity'
    }.to_not raise_error
  end

  it 'can be required with string-similarity' do
    expect {
      require 'string-similarity'
    }.to_not raise_error
  end
end
