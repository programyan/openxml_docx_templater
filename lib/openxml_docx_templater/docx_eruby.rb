module OpenxmlDocxTemplater
  class DocxEruby
    include Debug

    EMBEDDED_PATTERN = /\{%([=%]+)?(.*?)-?%\}/m

    def initialize template
      @src = convert template
      if debug?
        File.open(debug_file_path, 'w') do |f|
          f << @src
        end
      end
    end

    def evaluate context
      eval(@src, context)
    end

    private

    def convert template
      src = "_buf = '';"
      buffer = []

      template.each_node do |node, type|
        buffer << process_instruction(node)
        buffer.flatten!
      end

      buffer.each { |line| src << line.to_buf }
      src << "\n_buf.to_s\n"
    end

    def process_instruction text
      pos = 0
      src = []

      text.scan(EMBEDDED_PATTERN) do |indicator, code|
        m = Regexp.last_match
        middle = text[pos...m.begin(0)]
        pos  = m.end(0)
        src << Line.text(middle) unless middle.empty?

        if !indicator            # <% %>
          src << Line.code(code)
        elsif indicator == '='   # <%= %>
          src << Line.string(code)
        elsif indicator == '%'   # <%% %>
          src << Line.literal(code)
        end
      end

      rest = pos == 0 ? text : text[pos..-1]

      src << Line.text(rest) unless rest.nil? or rest.empty?
      src
    end
  end
end
