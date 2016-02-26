require 'zip'
require 'fileutils'

module OpenxmlDocxTemplater
  class Template
    attr_accessor :template

    def initialize(template, output)
      FileUtils.cp(template, output)
      @template = output
    end

    def process context
      tmpfiles = []
      Zip::File.open(@template) do |zipfile|
        %w(word/document.xml word/styles.xml).each do |xml_file|
          content = zipfile.read(xml_file).refact

          docxeruby = DocxEruby.new(XmlReader.new(content))
          out = docxeruby.evaluate(context)

          tmpfiles << (file = Tempfile.new("openxml_template"))
          file << out
          file.close

          zipfile.replace(xml_file, file.path)
        end
      end
    end
  end
end
