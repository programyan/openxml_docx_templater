# OpenxmlDocxTemplater

OpenxmlDocxTemplater is an embedded ruby for MS Office documents (.docx files). You provide an .docx template with ruby code inside a special markup and the data and this gem generates the document. If you know erb, all of this should sound familiar for you.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openxml_docx_templater'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openxml_docx_templater

## Usage

OpenxmlDocxTemplater is the best demonstrated with an example.
At the picture below, you can see the MS Word template with ruby code (this template, the output file, and the sample script can be found in examples directory).

![Template](https://github.com/AgeevAndrew/openxml_docx_templater/tree/master/examples/images/template.PNG?raw=true)

The image above is a screenshot of example_template.docx from the [examples](https://github.com/AgeevAndrew/openxml_docx_templater/tree/master/examples) directory. It's a regular Microsoft Office document with ruby code embedded inside a special markup. That ruby code drives the document creation. You can use conditionals, loops, blocks &mdash; in fact, the whole ruby language and you can apply any MS Office formatting to the outputted variables or static text.

The second line in the template is `{%= @title1 %}` that means: output the value of variable title1. That variable will be replaced in the generated document, but it'll still be a bold.

You can now take that template, provide the data and generate the final document:

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

        iphone_models = [Model.new('iPhone 6+', 'iPhone 6+ was released in ...', '$1000'),
          Model.new('iPhone 6', 'iPhone 6 was released in ...', '$700')]
        iphone = Brand.new("iPhone", iphone_models)

        @brands = [lg, iphone]

        render_msword 'example_template.docx'
      end
    end

The key parts are `include OpenxmlDocxTemplater::Generator` and `render_msword`. The data for the template must be provided as instance variables.

Following picture shows the generated document. It's a screenshot of the example_template_output.docx document from the [examples](https://github.com/AgeevAndrew/openxml_docx_templater/tree/master/examples) directory.

![Document](https://github.com/AgeevAndrew/openxml_docx_templater/tree/master/examples/images/output.PNG?raw=true)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

