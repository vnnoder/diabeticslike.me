module SimpleForm
  module Components
    module Tooltip
      def tooltip
        if options[:tooltip].present?
          tooltip = options[:tooltip]
          tooltip_content = tooltip.is_a?(String) ? tooltip : translate(:tooltips)
          tooltip_content.html_safe if tooltip_content
          template.content_tag(:i, '', :rel => 'tooltip', :class => 'icon icon-question-sign', :'data-original-title' => tooltip_content)
        end
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Tooltip)