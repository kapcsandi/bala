# module ActionView
#   module Helpers
#     class InstanceTag
# #      def to_label_tag_with_i18n(text = nil, options = {})
# #        text ||= object.class.human_attribute_name(method_name) if object.class.respond_to?(:human_attribute_name)
# 
# #        to_label_tag_without_i18n(text, options)
# #      end
# 
#       alias_method_chain :to_label_tag, :i18n
#     end
#   end
# end 