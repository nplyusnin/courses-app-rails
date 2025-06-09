# frozen_string_literal: true

class BulmaBuilder < ActionView::Helpers::FormBuilder
  def text_field(attribute, options = {})
    errors = object.errors[attribute]

    input_classes = ["input"]
    input_classes << "is-danger" if errors.any?

    input = @template.content_tag(:div, class: "control") do
      super(attribute, options.reverse_merge(class: input_classes))
    end

    wrap_and_assign_validation_errors(input_label(attribute) + input, errors)
  end

  def select(attribute, choices, options = {}, html_options = {})
    errors = object.errors[attribute]

    wrapper_classes = %w[select is-fullwidth]
    wrapper_classes << "is-danger" if errors.any?

    input = @template.content_tag(:div, class: wrapper_classes) do
      super(attribute, choices, options, html_options.reverse_merge(class: "is-fullwidth"))
    end

    field = input_label(attribute) + input
    field += @template.content_tag(:p, errors.join(", "), class: "help is-danger") if errors.any?
    field
  end

  def file_field(attribute, options = {})
    errors = object.errors[attribute]

    input_classes = ["file-input"]
    input_classes << "is-danger" if errors.any?

    input = @template.content_tag(:div, class: "file") do
      @template.content_tag(:label, class: "file-label") do
        super(attribute, options.reverse_merge(class: input_classes)) + custom_file_input
      end
    end

    wrap_and_assign_validation_errors(input_label(attribute) + input, errors)
  end

  def rich_textarea(attribute, _options = {})
    errors = object.errors[attribute]

    input = @template.content_tag(:div, class: "control") do
      super(attribute)
    end

    wrap_and_assign_validation_errors(input_label(attribute) + input, errors)
  end

  def submit(value = nil, options = {})
    options[:class] = "button"
    super
  end

  private

  def wrap_and_assign_validation_errors(input, errors)
    field = @template.content_tag(:div, class: "field") { input }
    field += validation_errors(errors) if errors.any?
    field
  end

  def validation_errors(errors)
    @template.content_tag(:p, errors.join(", "), class: "help is-danger")
  end

  def input_label(attribute)
    label(
      attribute,
      I18n.t("activerecord.attributes.#{object.model_name.singular}.#{attribute}"),
      class: "label"
    )
  end

  def custom_file_input
    @template.content_tag(:span, class: "file-cta") do
      @template.content_tag(:span, I18n.t("bulma_builder.choose_file"), class: "file-label")
    end
  end
end
