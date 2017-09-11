# frozen_string_literal: false

require 'spec_helper'

RSpec.describe String do
  let(:string) { '<w:t>&</w:t>' }
  describe '#escape_xml' do
    subject { string.escape_xml }

    let(:param) { [[/&/, '&amp;'], [/</, '&lt;'], [/>/, '&gt;']] }

    it do
      expect_any_instance_of(String).to receive(:mgsub!)
      subject
    end
  end
end
