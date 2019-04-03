# frozen_string_literal: true

module ApplicationHelper
  def nav_link(link_text, link_path, base_class = '')
    class_name = current_page?(link_path) ? 'nav-item active' : 'nav-item'
    class_name = "#{base_class} #{class_name}"
    content_tag(:li, class: class_name) do
      link_to link_text, link_path, class: 'nav-link'
    end
  end

  def passing_table_status(passing)
    passing ? 'table-success' : 'table-danger'
  end
end
