require 'rubygems'
require 'colorize'

namespace :dev do

  task :status do
      server_pidfile = "#{Rails.root}/tmp/pids/server.pid"
      mongo_pidfile = "#{Rails.root}/tmp/pids/mongo.pid"

      print "\n"
      print "\u00bb MongoDB: ".colorize(:light_yellow)
      if File.exists?(mongo_pidfile)
        print "Running\n".colorize(:green)
      else
        print "Not Running\n".colorize(:red)
      end

      print "\u00bb Webrick: ".colorize(:light_yellow)
      if File.exists?(server_pidfile)
        print "Running\n".colorize(:green)
      else
        print "Not Running\n".colorize(:red)
      end

  end

  namespace :start do

    desc "Startup all dependencies."
    task :all do
      # start mongo
      Rake::Task['dev:start:mongo'].execute

      # start webrick
      puts "\u00bb Starting Webrick...".colorize(:green)
      sh "rails server -d"
    end

    desc "Startup a MongoDB instance."
    task :mongo do
      unless File.exists?("#{Rails.root}/tmp/pids/mongo.pid")
        puts "\n\u00bb Starting MongoDB...".colorize(:green)
        sh "mongod run --pidfilepath=#{Rails.root}/tmp/pids/mongo.pid --dbpath=#{Rails.root}/db/ >> #{Rails.root}/log/mongodb.log &"
      else
        puts "MongoDB is already running.".colorize(:yellow)
      end
    end

    # aliases
    task :mongodb => :mongo
  end

  namespace :stop do

    desc "Stop all dependencies."
    task :all do
      Rake::Task['dev:stop:mongo'].execute

      server_p = File.read("#{Rails.root}/tmp/pids/server.pid").to_i
      begin
        Process.kill(2, server_p)
      rescue SystemCallError => e
        raise e
      else
        puts "\u00ab Killed Webrick #{server_p} with signal 2".colorize(:red)
      end
    end

    desc "Stop all MongoDB instances."
    task :mongo do
      pidfile = "#{Rails.root}/tmp/pids/mongo.pid"
      if File.exists?(pidfile)
          begin
            mongo_p = File.read(pidfile).to_i
            Process.kill(15,mongo_p)
          rescue SystemCallError => e
            raise e
          else
            puts "\n\u00ab Killed MongoDB #{mongo_p} with signal 15".colorize(:red)
            sh "rm #{pidfile}"
          end
      else
        puts "No MongoDB process is running.".colorize(:yellow)
      end
    end

    # aliases
    task :mongodb => :mongo
  end

  task :start do
    Rake::Task['dev:start:all'].invoke
  end

  task :stop do
    Rake::Task['dev:stop:all'].invoke
  end

end
