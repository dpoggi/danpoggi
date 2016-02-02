require 'fileutils'
require 'tmpdir'

class LatexFilter < Nanoc::Filter
  identifier :latex
  type :binary

  def run(filename, params = {})
    output_withoutext = File.basename(output_filename).sub(/#{Regexp.escape(File.extname(output_filename))}$/, '')

    Dir.mktmpdir do |dir|
      input_path = File.join(dir, "#{output_withoutext}.tex")
      FileUtils.cp(filename, input_path)
      output_path = File.join(dir, "#{output_withoutext}.pdf")

      Dir.chdir(dir) do
        system('pdflatex', input_path)
        raise 'pdflatex failed!' unless $? == 0
        FileUtils.cp(output_path, output_filename)
      end
    end
  end
end
