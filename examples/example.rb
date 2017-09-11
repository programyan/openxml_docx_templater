$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'openxml_docx_templater'

class Example
  include OpenxmlDocxTemplater::Generator

  Brand = Struct.new(:name, :models)
  Model = Struct.new(:name, :description, :cost)

  def generate
    @is_usa = true
    @title1 = "Price"
    @title2 = "Прайс"

    lg_models = [Model.new('Google Nexus 5x', 'LG Nexus 5x was released in November 2015.', '$550'),
      Model.new('Google Nexus 5', 'LG Nexus 5 was released in November 2013.', '$350'),
      Model.new('Google Nexus 6p', 'LG nexus 6p was released in November 2015.', '$750'),
      ]
    lg = Brand.new("LG", lg_models)

    iphone_models = [Model.new('iPhone 6+', 'iPhone 6+ was released in September 2014.', '$1000'),
      Model.new('iPhone 6', 'iPhone 6 was released in September 2014.', '$700')]
    iphone = Brand.new("iPhone", iphone_models)

    @brands = [lg, iphone]

    render_msword 'example_template.docx'
  end
end

example = Example.new
example.generate
