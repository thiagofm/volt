require 'volt/page/bindings/base_binding'

class TemplateRenderer < BaseBinding
  attr_reader :context
  def initialize(page, target, context, binding_name, template_name)
    super(page, target, context, binding_name)

    @sub_bindings = []

    bindings = self.dom_section.set_content_to_template(page, template_name)

    bindings.each_pair do |id,bindings_for_id|
      bindings_for_id.each do |binding|
        @sub_bindings << binding.call(page, target, context, id)
      end
    end
  end

  def remove
    @sub_bindings.each(&:remove)
    @sub_bindings = []

    super
  end
end
