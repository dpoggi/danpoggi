require 'nanoc3/tasks'

task :deploy do
  if not `hash s3cmd 2>&1`.empty?
    $stderr.puts 'Yo dawg, you gots to get s3cmd. For reals.'
    exit 1
  end

  Rake::Task['clean'].reenable
  Rake::Task['clean'].invoke

  puts `bundle exec nanoc3 compile`
  Dir.glob('output/*') do |item|
    if File.directory? item
      puts `s3cmd sync #{item} s3://www.danpoggi.com/`
    else
      puts `s3cmd put #{item} s3://www.danpoggi.com/`
    end
  end
end
