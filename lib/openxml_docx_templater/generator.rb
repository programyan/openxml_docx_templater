# frozen_string_literal: true

module OpenxmlDocxTemplater
  module Generator
    def render_msword(template_path, output_path = output_name(template_path))
      template = Template.new template_path, output_path
      template.process binding
    end

    private

    def output_name(input)
      if input =~ /(.+)\.docx\Z/
        "#{Regexp.last_match(1)}_output.docx"
      else
        "#{input}_output.docx"
      end
    end
  end
end
