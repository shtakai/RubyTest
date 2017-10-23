require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataValidTest < BaseClassForTest

  def test_flat_data_valid
    prelude do |client, log|
      label = Label.get_first(client)
      log.section('This is valid') do
        label.verdict_valid?(log, 'label valid')
      end
      log.section('This is not valid') do
        label.color = Label.invalid_value_for(:color)
        label.verdict_valid?(log, 'label not valid')
      end
    end
  end

end
