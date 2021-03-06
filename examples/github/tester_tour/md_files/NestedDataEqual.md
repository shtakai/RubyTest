<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Creating Nested Data Objects, Part 2](./NestedDataNew2.md#creating-nested-data-objects-part-2)

**Next Stop:** [Validating Nested Data Objects](./NestedDataValid.md#validating-nested-data-objects)


# Verifying Nested Data Objects

Nested data objects can be verified recursively.

## Example Test

<code>nested_data_equal_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataEqualTest < BaseClassForTest

  def test_nested_data_equal
    prelude do |log|
      with_api_client(log) do |api_client|
        rate_limit_0 = RateLimit.get(api_client)
        rate_limit_1 = RateLimit.deep_clone(rate_limit_0)
        log.section('These are equal') do
          fail unless RateLimit.equal?(rate_limit_0, rate_limit_1)
          RateLimit.verdict_equal?(log, :rate_limits_equal, rate_limit_0, rate_limit_1, 'Using RateLimit.verdict_equal?')
        end
        log.section('These are not equal') do
          rate_limit_1.resources.core.limit = RateLimit::Core_.invalid_value_for(:limit)
          fail if RateLimit.equal?(rate_limit_0, rate_limit_1)
          RateLimit.verdict_equal?(log, :rate_limits_not_equal, rate_limit_0, rate_limit_1, 'Using RateLimit.verdict_equal?')
        end
      end
    end
  end

end
```

Notes:

- Use method `equal?` to test nested data object equality, without logging.
- Use method `verdict_equal?` to test nested object equality, including logging.
- The test gets a known `RateLimit`, then clones it.
- We know that `RateLimit` has nested data objects, so it's _necessary_ to use `deep_clone`, not `clone`.
- In section `These are equal`:
  - Method `RateLimit.equal?` tests equality, but does no logging.
  - The `fail unless` proves that it worked.
  - Method `RateLimit.verdict_equal?` verifies and logs each value in the rate limit.
- In section `These are not equal`:
  - One value in the rate limit is modified.  The changed value is in a nested object.
  - Method `RateLimit.equal?` test equality, but does no logging.
  - The `fail if ` proves that it worked.
  - Method `RateLimit.verdict_equal?` verifies and logs each value in the rate limit.

## Log

<code>test_nested_data_equal.xml</code>
```xml
<nested_data_equal_test>
  <summary errors='0' failures='1' verdicts='25'/>
  <test_method duration_seconds='3.806' name='nested_data_equal_test' timestamp='2018-01-15-Mon-13.28.46.694'>
    <section name='Test'>
      <ApiClient method='GET' url='https://api.github.com/rate_limit'>
        <execution duration_seconds='3.775' timestamp='2018-01-15-Mon-13.28.46.694'/>
      </ApiClient>
      <section name='These are equal'>
        <section class='RateLimit' method='verdict_equal?' name='rate_limits_equal'>
          <section class='RateLimit' method='verdict_equal_recursive?' name='rate_limits_equal'>
            <section class='RateLimit' method='verdict_equal_recursive?' name='resources'>
              <verdict id='rate_limits_equal:resources:core:limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>5000</exp_value>
                <act_value>5000</act_value>
              </verdict>
              <verdict id='rate_limits_equal:resources:core:remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>4888</exp_value>
                <act_value>4888</act_value>
              </verdict>
              <verdict id='rate_limits_equal:resources:core:reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1516044999</exp_value>
                <act_value>1516044999</act_value>
              </verdict>
            </section>
            <section class='RateLimit' method='verdict_equal_recursive?' name='resources'>
              <verdict id='rate_limits_equal:resources:search:limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>30</exp_value>
                <act_value>30</act_value>
              </verdict>
              <verdict id='rate_limits_equal:resources:search:remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>30</exp_value>
                <act_value>30</act_value>
              </verdict>
              <verdict id='rate_limits_equal:resources:search:reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1516044591</exp_value>
                <act_value>1516044591</act_value>
              </verdict>
            </section>
            <section class='RateLimit' method='verdict_equal_recursive?' name='resources'>
              <verdict id='rate_limits_equal:resources:graphql:limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>5000</exp_value>
                <act_value>5000</act_value>
              </verdict>
              <verdict id='rate_limits_equal:resources:graphql:remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>5000</exp_value>
                <act_value>5000</act_value>
              </verdict>
              <verdict id='rate_limits_equal:resources:graphql:reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1516048131</exp_value>
                <act_value>1516048131</act_value>
              </verdict>
            </section>
          </section>
          <section class='RateLimit' method='verdict_equal_recursive?' name='rate_limits_equal'>
            <verdict id='rate_limits_equal:rate:limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>5000</exp_value>
              <act_value>5000</act_value>
            </verdict>
            <verdict id='rate_limits_equal:rate:remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>4888</exp_value>
              <act_value>4888</act_value>
            </verdict>
            <verdict id='rate_limits_equal:rate:reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>1516044999</exp_value>
              <act_value>1516044999</act_value>
            </verdict>
          </section>
        </section>
      </section>
      <section name='These are not equal'>
        <section class='RateLimit' method='verdict_equal?' name='rate_limits_not_equal'>
          <section class='RateLimit' method='verdict_equal_recursive?' name='rate_limits_not_equal'>
            <section class='RateLimit' method='verdict_equal_recursive?' name='resources'>
              <verdict id='rate_limits_not_equal:resources:core:limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='failed' volatile='false'>
                <exp_value>5000</exp_value>
                <act_value>0</act_value>
                <exception>
                  <class>Minitest::Assertion</class>
                  <message>Expected: 5000 Actual: 0</message>
                  <backtrace>
                    <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:158:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:154:in `block (2 levels) in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:152:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:154:in `block (2 levels) in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:152:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:72:in `block in verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:71:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/nested_data_equal_test.rb:19:in `block (3 levels) in test_nested_data_equal'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/nested_data_equal_test.rb:16:in `block (2 levels) in test_nested_data_equal'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:28:in `block in with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/api_client.rb:19:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:27:in `with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/nested_data_equal_test.rb:9:in `block in test_nested_data_equal'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:21:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:20:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:12:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/nested_data_equal_test.rb:8:in `test_nested_data_equal']]>
                  </backtrace>
                </exception>
              </verdict>
              <verdict id='rate_limits_not_equal:resources:core:remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>4888</exp_value>
                <act_value>4888</act_value>
              </verdict>
              <verdict id='rate_limits_not_equal:resources:core:reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1516044999</exp_value>
                <act_value>1516044999</act_value>
              </verdict>
            </section>
            <section class='RateLimit' method='verdict_equal_recursive?' name='resources'>
              <verdict id='rate_limits_not_equal:resources:search:limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>30</exp_value>
                <act_value>30</act_value>
              </verdict>
              <verdict id='rate_limits_not_equal:resources:search:remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>30</exp_value>
                <act_value>30</act_value>
              </verdict>
              <verdict id='rate_limits_not_equal:resources:search:reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1516044591</exp_value>
                <act_value>1516044591</act_value>
              </verdict>
            </section>
            <section class='RateLimit' method='verdict_equal_recursive?' name='resources'>
              <verdict id='rate_limits_not_equal:resources:graphql:limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>5000</exp_value>
                <act_value>5000</act_value>
              </verdict>
              <verdict id='rate_limits_not_equal:resources:graphql:remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>5000</exp_value>
                <act_value>5000</act_value>
              </verdict>
              <verdict id='rate_limits_not_equal:resources:graphql:reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1516048131</exp_value>
                <act_value>1516048131</act_value>
              </verdict>
            </section>
          </section>
          <section class='RateLimit' method='verdict_equal_recursive?' name='rate_limits_not_equal'>
            <verdict id='rate_limits_not_equal:rate:limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>5000</exp_value>
              <act_value>5000</act_value>
            </verdict>
            <verdict id='rate_limits_not_equal:rate:remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>4888</exp_value>
              <act_value>4888</act_value>
            </verdict>
            <verdict id='rate_limits_not_equal:rate:reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>1516044999</exp_value>
              <act_value>1516044999</act_value>
            </verdict>
          </section>
        </section>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</nested_data_equal_test>
```

- Each actual value, even one that's in a nested object, is verified in a separate verdict.
- In section `These are equal`, all verdicts pass.
- In section `These are not equal`, one (deeply nested) verdict fails.

**Prev Stop:** [Creating Nested Data Objects, Part 2](./NestedDataNew2.md#creating-nested-data-objects-part-2)

**Next Stop:** [Validating Nested Data Objects](./NestedDataValid.md#validating-nested-data-objects)

