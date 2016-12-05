module ApplicationHelper

  def tab title, link, css_class: '', active_links: [], match_subpaths: false
    active_links = [link] + active_links
    if match_subpaths
      active = active_links.any?{ |active_link| request.path.index(active_link) }
    else
      active = active_links.include?(request.path)
    end
    class_name = active ? css_class + ' active' : css_class
    content_tag(:li, class: class_name) do
    link_to title, link
    end
  end

end
