# frozen_string_literal: true

require 'spec_helper'

module OpenxmlDocxTemplater
  RSpec.describe XmlReader do
    let(:src) { '' }
    describe '#node_type' do
      subject { described_class.new(src).node_type(text) }

      context 'control' do
        let(:text) { '{% abc %}' }
        it { should eq OpenxmlDocxTemplater::NodeType::CONTROL }
      end

      context 'template' do
        let(:text) { '{%= abc %}' }
        it { should eq OpenxmlDocxTemplater::NodeType::TEMPLATE }
      end
    end
  end
end
