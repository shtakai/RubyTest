<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Creating a Data Object](./FlatDataNew.md#creating-a-data-object)

**Next Stop:** [Validating a Data Object](./FlatDataValid.md#validating-a-data-object)


# Verifying a Data Object

A data class has methods for:

- Testing for object equality (without logging).
- Verifying object equality (with logging).

## Example Test

<code>flat_data_equal_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataEqualTest < BaseClassForTest

  def test_flat_data_equal
    prelude do |log, api_client|
      label_0 = nil
      log.section('Fetch an instance of Label') do
        log.section('Fetch a label') do
          label_0 = Label.get_first(api_client)
        end
      end
      label_1 = Label.deep_clone(label_0)
      log.section('These are equal') do
        fail unless Label.equal?(label_0, label_1)
        Label.verdict_equal?(log, :label_equal, label_0, label_1)
      end
      log.section('These are not equal') do
        label_1.perturb!
        fail if Label.equal?(label_0, label_1)
        Label.verdict_equal?(log, :label_not_equal, label_0, label_1)
      end
    end
  end

end
```

Notes:

- Use method `equal?` to test data object equality, without logging.
- Use method `verdict_equal?` to test object equality, including logging.
- The test gets a known `Label`, then clones it.
- We know that `Label` is flat, but it's good practice to use `deep_clone`, not `clone` just to be sure.
- In section `These are equal`:
  - Method `Label.equal?` tests equality, but does no logging.
  - The `fail unless` proves that it worked.
  - Method `Label.verdict_equal?` verifies and logs each value in the rate limit.
- In section `These are not equal`:
  - One value in the rate limit is modified.
  - Method `Label.equal?` tests equality, but does no logging.
  - The `fail if ` proves that it worked.
  - Method `Label.verdict_equal?` verifies and logs each value in the rate limit.

## Log

<code>test_flat_data_equal.xml</code>
```xml
<flat_data_equal_test>
  <summary errors='0' failures='1' verdicts='11'/>
  <test_method name='flat_data_equal_test' timestamp='2017-12-09-Sat-10.49.16.259'>
    <section name='Test'>
      <section name='Fetch an instance of Label'>
        <section name='Fetch a label'>
          <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
            <execution duration_seconds='1.763' timestamp='2017-12-09-Sat-10.49.16.259'/>
          </ApiClient>
        </section>
      </section>
      <section duration_seconds='1.841' name='These are equal'>
        <section class='Label' method='verdict_equal?' name='label_equal'>
          <verdict id='label_equal:id' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>710733208</exp_value>
            <act_value>710733208</act_value>
          </verdict>
          <verdict id='label_equal:url' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug</exp_value>
            <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug</act_value>
          </verdict>
          <verdict id='label_equal:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>bug</exp_value>
            <act_value>bug</act_value>
          </verdict>
          <verdict id='label_equal:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>ee0701</exp_value>
            <act_value>ee0701</act_value>
          </verdict>
          <verdict id='label_equal:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>true</exp_value>
            <act_value>true</act_value>
          </verdict>
        </section>
        <section name='These are not equal'>
          <section class='Label' method='verdict_equal?' name='label_not_equal'>
            <verdict id='label_not_equal:id' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>710733208</exp_value>
              <act_value>710733208</act_value>
            </verdict>
            <verdict id='label_not_equal:url' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug</exp_value>
              <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug</act_value>
            </verdict>
            <verdict id='label_not_equal:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>bug</exp_value>
              <act_value>bug</act_value>
            </verdict>
            <verdict id='label_not_equal:color' method='verdict_assert_equal?' outcome='failed' volatile='false'>
              <exp_value>ee0701</exp_value>
              <act_value>000000</act_value>
              <exception>
                <class>Minitest::Assertion</class>
                <message>
                  --- expected +++ actual @@ -1,2 +1,2 @@ # encoding: UTF-8
                  -&quot;ee0701&quot; +&quot;000000&quot;
                </message>
                <backtrace>
                  <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:154:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:142:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:69:in `block in verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:68:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/tester_tour/tests/flat_data_equal_test.rb:23:in `block (2 levels) in test_flat_data_equal'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/tester_tour/tests/flat_data_equal_test.rb:20:in `block in test_flat_data_equal'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/base_classes/base_class_for_test.rb:21:in `block (3 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/api_client.rb:19:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/base_classes/base_class_for_test.rb:20:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/base_classes/base_class_for_test.rb:19:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/tester_tour/tests/flat_data_equal_test.rb:8:in `test_flat_data_equal']]>
                </backtrace>
              </exception>
            </verdict>
            <verdict id='label_not_equal:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>true</exp_value>
              <act_value>true</act_value>
            </verdict>
          </section>
        </section>
      </section>
      <section name='Count of errors (unexpected exceptions)'>
        <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
          <exp_value>0</exp_value>
          <act_value>0</act_value>
        </verdict>
      </section>
    </section>
  </test_method>
</flat_data_equal_test>
```

Notes:

- Each actual value is verified in a separate verdict.
- In section `These are equal`, all verdicts pass.
- In section `These are not equal`, one verdict fails.

**Prev Stop:** [Creating a Data Object](./FlatDataNew.md#creating-a-data-object)

**Next Stop:** [Validating a Data Object](./FlatDataValid.md#validating-a-data-object)
