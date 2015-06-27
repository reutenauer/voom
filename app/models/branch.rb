require 'tmpdir'
require 'fileutils'

class Branch
  @@tmpdir = Dir.mktmpdir
  PREVOOM = 0
  INVOOM = 1
  POSTVOOM = 2

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

    voomstart = "# ==== Managed by the Voom below ===="
    voomstop = "# ==== Managed by the Voom above ===="

    state = PREVOOM
    prevoom = ""
    postvoom = ""
    oldconf.each_line do |line|
      if state == PREVOOM
        prevoom += line
      elsif state == INVOOM
      elsif state == POSTVOOM
        postvoom += line
      end

      if line =~ /#{voomstart}/
        state = INVOOM
      elsif line =~ /#{voomstop}/
        state = POSTVOOM
      end
    end

    newconf = File.open(conffile, 'w')
    newconf.write prevoom
    Heading.order(:rank).each do |heading|
      newconf.puts "" unless heading.rank == 10
      newconf.puts "        ##{heading.title}"
      Redirect.where(heading_id: heading.id).sort do |a, b|
        a.source.downcase <=> b.source.downcase
      end.each do |redirect|
        l = redirect.source.length
        padding = if l < 23 then ' ' * (23 - l) else ' ' end
        puts "DEBUG #{redirect.source} #{redirect.source.length}"
        newconf.puts "        Redirect 301 #{redirect.source}#{padding}#{redirect.target}"
      end
    end
    newconf.write ' ' * 8 + voomstop + "\n"
    newconf.write postvoom

    # conf = File.open(conffile, 'w')
    # conf.puts "        Redirect 301 #{source}   #{target}"
    # conf.close
    system("git diff")
    `git commit -m 'Commit from the Voom.'`
    # puts `git push -u origin #{branch}`
  end
end
