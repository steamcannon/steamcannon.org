module ReleaseHelper

  def release_for_version(version)
    site.releases.find { |release| release.version == version }
  end

  def announcement_for_version(version)
    site.posts.find { |p| p.layout == 'release' && p.version == version }
  end

  def current_ami
    site.releases.first.ami
  end

end
