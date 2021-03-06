require_relative 'constants'

module VerdictBoolean

  # TODO:  Create test for this module.
  # TODO:  Create examples for this module.

  Contract VERDICT_ID, Any, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict asserting a boolean.
  def verdict_assert_boolean?(verdict_id, actual, message: nil, volatile: false)
    boolean_classes = [
        TrueClass,
        FalseClass,
    ]
    va_includes?(verdict_id, boolean_classes, actual.class, message: message, volatile: volatile)
  end
  alias va_boolean? verdict_assert_boolean?

end
