# frozen_string_literal: true

class String
  CODE_LINE_PATTERN = /{([^{]*?)%(.+?)%(.*?)}/
  TAG_PATTERN = /<(.+?)>[\n]?/m

  def escape_xml
    mgsub(/&/ => '&amp;', /</ => '&lt;', />/ => '&gt;')
  end

  def convert_newlines
    gsub("\n", '<w:br/>')
  end

  def refact
    gsub(CODE_LINE_PATTERN) { |result| result.gsub(TAG_PATTERN, '') }
  end

  def mgsub(key_value_pairs = {})
    regexp_fragments = key_value_pairs.keys
    gsub(Regexp.union(*regexp_fragments)) do |match|
      key_value_pairs.detect { |k, _v| k =~ match }[1]
    end
  end
end
