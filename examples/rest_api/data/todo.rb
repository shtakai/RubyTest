require_relative 'base_class_for_resource'

class Todo < BaseClassForResource

  FIELDS = Set.new([
         :userId,
         :id,
         :title,
         :completed,
  ])

  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :userId,
      :completed

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
    nil
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Todo, self, 'First object is of class Todo')
      log.verdict_assert_integer_positive?(verdict_id + ' - user id', self.userId, 'Todo user id')
      log.verdict_assert_integer_positive?(verdict_id + ' - id', self.id, 'Todo id')
      log.verdict_assert_string_not_empty?(verdict_id + ' - title', self.title, 'Todo title')
      log.verdict_assert_boolean?(verdict_id + ' - completed', self.completed, 'Todo completed')
    end
  end

end
