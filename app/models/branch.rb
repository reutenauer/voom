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

    conffile = 'etc/apache2/sites-available/default.conf'
    oldconf = File.read(conffile)
    newconf = File.open(conffile, 'w')

    prevoom = ""
    oldconf.each_line do |line|
      prevoom += line
      prevoom += "\n"
      break if line =~ /# ==== Managed by the Voom below ====/
    end

    oldconf.each_line do |line|
      break if line =~ /# ==== Managed by the Voom above ====/
    end

    postvoom = ""
    oldconf.each_line do |line|
      postvoom += line
      postvoom += "\n"
      newconf.puts line
    end

    newconf.write prevoom
    Redirect.all.each do |redirect|
      l = redirect.source.length
      padding = if l < 23 then ' ' * (23 - l) else ' ' end
      puts "DEBUG #{redirect.source} #{redirect.source.length}"
      newconf.puts "        Redirect 302 #{redirect.source}#{padding}#{redirect.target}"
    end
    newconf.write postvoom

    # conf = File.open(conffile, 'w')
    # conf.puts "        Redirect 301 #{source}   #{target}"
    # conf.close
    system("git diff")
    `git commit -m 'Commit from the Voom.'`
    # puts `git push -u origin #{branch}`
  end
end
