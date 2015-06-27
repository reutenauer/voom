require 'tmpdir'
require 'fileutils'

class Branch
  @@tmpdir = Dir.mktmpdir

  def self.add_vanity_url(source, target)
    puts @@tmpdir
    FileUtils.chdir @@tmpdir
    `git clone -b voom-base ssh://git@stash.atlassian.roh.org.uk/web/server-configuration---content.git`
    t = Time.now.utc.strftime('%Y%m%dT%H%M%S')
    branch = "voom-#{t}"
    FileUtils.chdir 'server-configuration---content'
    `git checkout -b #{branch}`
    conf = File.open('etc/apache2/sites-available/default.conf', 'w')
    conf.puts "        Redirect 301 #{source}   #{target}"
    conf.close
    `git commit -m 'Commit from the Voom.'`
    puts `git push -u origin #{branch}`
  end
end
