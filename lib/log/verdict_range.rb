require_relative 'constants'

module VerdictRange

  # TODO:  Create test for this module.
  # TODO:  Create examples for this module.

  Contract VERDICT_ID, Range, Any, VERDICT_MESSAGE, VERDICT_VOLATILE => Bool
  # \Log a verdict asserting range membership.
  def verdict_assert_in_range?(verdict_id, range, actual, message: nil, volatile: false)
    passed = nil
    section('Value in range') do
      put_element('exp_range', range)
      put_element('act_value', actual)
      passed = va?(verdict_id, range.include?(actual), message: message, volatile: volatile)
    end
    passed
  end
  alias va_in_range? verdict_assert_in_range?

end