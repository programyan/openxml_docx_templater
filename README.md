# OpenxmlDocxTemplater

OpenxmlDocxTempleter allows you to embed ruby code in MS Office documents (.docx files). You provide .docx template with ruby code, inside a special markup, and the data. In this way gem generates the document. It must be familiar to you, if you know erb!

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

OpenxmlDocxTemplater is the best to demonstrate with an example.
At the picture shown below, you can see the MS Word template with ruby code (this template, the output file, and the sample script can be found in [examples directory](https://github.com/AgeevAndrew/openxml_docx_templater/tree/master/examples)).

![Template](https://github.com/AgeevAndrew/openxml_docx_templater/tree/master/examples/images/template.PNG?raw=true)

This image is a screenshot of example_template.docx from the [examples directory](https://github.com/AgeevAndrew/openxml_docx_templater/tree/master/examples). It is a regular Microsoft Office document with ruby code, embedded inside a special markup. That ruby code drives the document creation. You can use conditions, loops, blocks &mdash; in fact, the whole ruby language. And you can apply any MS Office formatting to the outputted variables or static text.

The second line in the template is `{%= @title1 %}`. That means output the value of variable `title1`. This variable will be replaced in the generated document, but it will still be bold.

You can take that template, provide the data and generate the final document:

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

The key parts are `include OpenxmlDocxTemplater::Generator` and `render_msword`. The data for the template must be provided as instance variables.

Following picture shows the generated document. It is a screenshot of the example_template_output.docx document from the [examples directory](https://github.com/AgeevAndrew/openxml_docx_templater/tree/master/examples).

![Document](https://github.com/AgeevAndrew/openxml_docx_templater/tree/master/examples/images/output.PNG?raw=true)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

