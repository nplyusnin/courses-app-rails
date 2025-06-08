# Disable input autowrapper div with class "field_with_errors"
ActionView::Base.field_error_proc = proc do |html_tag, _|
  html_tag.html_safe
end