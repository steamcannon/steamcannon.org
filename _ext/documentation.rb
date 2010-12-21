class Documentation
  def execute(site)
    current_path = File.join(site.output_dir, 'documentation', 'current')
    FileUtils.rm_rf(current_path)

    site.releases.each do |release|
      doc_bundle_name = "steamcannon-docs-en_US-#{release.version}-html.zip"
      doc_bundle_path = File.join(site.output_dir, 'documentation', 'download', doc_bundle_name)
      doc_root = File.join(site.output_dir, 'documentation', release.version)

      if File.exist?(doc_bundle_path)
        if release == site.releases.first
          FileUtils.cd(File.join(site.output_dir, 'documentation')) do |dir|
            FileUtils.ln_s(release.version, 'current')
          end
        end
        unless File.exist?(File.join(doc_root, 'index.html'))
          puts "Unzipping doc bundle for #{release.version}"
          `unzip -q #{doc_bundle_path} -d #{doc_root}`
        end
      end
    end
  end
end
