# frozen_string_literal: true

require 'spec_helper'

RSpec.describe String do
  let(:string) { '<w:t>&</w:t>' }
  describe '#escape_xml' do
    subject { string.escape_xml }

    let(:param) { [[/&/, '&amp;'], [/</, '&lt;'], [/>/, '&gt;']] }

    it do
      should eq '&lt;w:t&gt;&amp;&lt;/w:t&gt;'
    end
  end

  describe '#convert_newlines' do
    subject { string.convert_newlines }

    context 'string has new lines' do
      let(:string) do
        <<~STRING.strip
          One Line
          Two Line
          Three Line
        STRING
      end

      it { should eq 'One Line<w:br/>Two Line<w:br/>Three Line' }
    end

    context 'string has no new lines' do
      let(:string) { 'One Two Three' }

      it { should eq string }
    end
  end
end
