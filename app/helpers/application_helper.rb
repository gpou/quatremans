module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Quatremans"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  #def link_to(body, url, html_options = {})
  #  super(body, url, { title: body }.merge(html_options))
  #end

end
