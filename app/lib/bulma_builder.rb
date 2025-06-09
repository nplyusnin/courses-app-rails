class BulmaBuilder < ActionView::Helpers::FormBuilder
  def text_field(attribute, options={})
    errors = object.errors[attribute]

    input_classes = ["input"]
    input_classes << "is-danger" if errors.any?

    input_label = label(attribute, I18n.t("activerecord.attributes.#{object.model_name.singular}.#{attribute}"), class: "label")
    input = @template.content_tag(:div, class: "control") do
      super(attribute, options.reverse_merge(class: input_classes))
    end

    field = @template.content_tag(:div, class: "field") { input_label + input }
    field += @template.content_tag(:p, errors.join(", "), class: "help is-danger") if errors.any?
    field
  end

  def select(attribute, choices, options={}, html_options={})
    errors = object.errors[attribute]

    wrapper_classes = ["select", "is-fullwidth"]
    wrapper_classes << "is-danger" if errors.any?

    input_label = label(attribute, I18n.t("activerecord.attributes.#{object.model_name.singular}.#{attribute}"), class: "label")
    input = @template.content_tag(:div, class: wrapper_classes) do
      super(attribute, choices, options, html_options.reverse_merge(class: "is-fullwidth"))
    end

    field = input_label + input
    field += @template.content_tag(:p, errors.join(", "), class: "help is-danger") if errors.any?
    field
  end

  def file_field(attribute, options={})
    errors = object.errors[attribute]

    input_classes = ["file-input"]
    input_classes << "is-danger" if errors.any?

    input_label = label(attribute, I18n.t("activerecord.attributes.#{object.model_name.singular}.#{attribute}"), class: "label")
    input = @template.content_tag(:div, class: "file") do
      @template.content_tag(:label, class: "file-label") do
        super(attribute, options.reverse_merge(class: input_classes)) +
        @template.content_tag(:span, class: "file-cta") do
          @template.content_tag(:span, I18n.t("bulma_builder.choose_file"), class: "file-label")
        end
      end
    end

    field = @template.content_tag(:div, class: "field") { input_label + input }
    field += @template.content_tag(:p, errors.join(", "), class: "help is-danger") if errors.any?
    field
  end

  def rich_textarea(attribute, options={})
    errors = object.errors[attribute]

    input_label = label(attribute, I18n.t("activerecord.attributes.#{object.model_name.singular}.#{attribute}"), class: "label")
    input = @template.content_tag(:div, class: "control") do
      super(attribute)
    end

    field = @template.content_tag(:div, class: "field") { input_label + input }
    field += @template.content_tag(:p, errors.join(", "), class: "help is-danger") if errors.any?
    field
  end

  def submit(value = nil, options = {})
    options[:class] = "button"
    super(value, options)
  end
end