module Steps
  def steps(options = {})
    template                = options[:template] || "template.html.haml"
    path_prefix             = options[:path_prefix] || "."
    steps                   = options[:steps] || []
    default_image_extension = options[:default_image_extension] || "png"

    original_layout = site.engine.load_site_page(step_path(template))
    pages = []
    if original_layout
      steps.each_with_index do |path, index|
        layout = original_layout.clone
        page = site.engine.load_site_page(step_path(path_prefix, path))
        layout.step_number = index + 1
        layout.step_title = page.title
        layout.step_text = page.content

        page.image ||= default_image(path_prefix, path, default_image_extension)
        image = site.engine.load_page(step_path(path_prefix, page.image))
        if image
          image.output_path = "/#{step_path(path_prefix, page.image)}"
          site.pages << image
          layout.step_image = image.output_path
        end
        pages << layout.content
      end
    end
    pages.join
  end

  protected

  def step_path(*args)
    File.join('_steps', *args)
  end

  def default_image(path_prefix, path, default_image_extension)
    page_path = step_path(path_prefix, path)
    "#{File.basename(page_path, File.extname(page_path))}.#{default_image_extension}"
  end
end
