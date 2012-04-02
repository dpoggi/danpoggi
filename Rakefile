require 'nanoc3/tasks'

task :default do
  Rake::Task['deploy:s3'].reenable
  Rake::Task['deploy:s3'].invoke
end

namespace :deploy do
  desc 'Upload the compiled site to Amazon S3'
  task :s3 do
    if not `hash s3cmd 2>&1`.empty?
      $stderr.puts 'Yo dawg, you gots to get s3cmd. For reals.'
      exit 1
    end

    Rake::Task['clean'].reenable
    Rake::Task['clean'].invoke

    puts `bundle exec nanoc compile`
    Dir.glob('output/*') do |item|
      if File.directory? item
        puts `s3cmd sync #{item} s3://www.danpoggi.com/`
      else
        puts `s3cmd put #{item} s3://www.danpoggi.com/`
      end
    end
  end
end
