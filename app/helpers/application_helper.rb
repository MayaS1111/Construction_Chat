module ApplicationHelper
  def error_notification
    if resource.errors.any?
      content_tag :div, class: 'error_notification' do
        concat(content_tag(:h2, "There were problems with your submission:"))
        concat(content_tag(:ul) do
          resource.errors.full_messages.each do |msg|
            concat(content_tag(:li, msg))
          end
        end)
      end
    end
  end
end
