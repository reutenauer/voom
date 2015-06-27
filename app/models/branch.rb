require 'tmpdir'
require 'fileutils'

class Branch
  @@tmpdir = Dir.mktmpdir

  def self.create
    FileUtils.chdir @@tmpdir
    `git clone ssh://git@stash.atlassian.roh.org.uk/web/server-configuration---content.git`
    FileUtils.chdir 'server-configuration---content'
    conf = File.open('etc/apache2/sites-available/default.conf', 'w')
    conf.puts "        Redirect 301 #{source}   #{target}"
  end
end
