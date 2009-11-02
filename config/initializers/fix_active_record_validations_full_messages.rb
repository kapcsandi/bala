# Ensures that when we pass a :message parameter to our validations, that
# message is a sentence (and not something to be prefixed by the column
# name). Rationale: ActiveSupport::Inflector is in over its head on this
# one.
#
# So instead of:
#   validates_presence_of :name, :message => 'should not be blank'
# Use:
#   validates_presence_of :name, :message => 'Name should not be blank'
#
# If, however, you just use:
#   validates_presence_of :name
# The behavior will remain unchanged.
if RAILS_GEM_VERSION =~ /^2\.3/
  ActiveRecord::Errors.class_eval do
    # Remove complicated logic
    def full_messages
      returning full_messages = [] do
        @errors.each_key do |attr|
          @errors[attr].each do |msg|
            full_messages << msg if msg 
          end 
        end 
      end 
    end 
  end 
end
