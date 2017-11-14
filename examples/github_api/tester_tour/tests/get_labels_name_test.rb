require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/get_labels_name'

class GetLabelsNameTest < BaseClassForTest

  def test_get_labels_name

    prelude do |client, log|

      log.section('Test GetLabelsName') do
        label_to_fetch = nil
        log.section('Create the label to be fetched') do
          label_to_create = Label.new(
              :id => nil,
              :url => nil,
              :name => 'test_label',
              :color => '000000',
              :default => false,
          )
          label_to_create.delete_if_exist?(client)
          label_to_fetch = label_to_create.create(client)
        end
        log.section('Test fetching the created label') do
          GetLabelsName.verdict_call_and_verify_success(client, :get_label, label_to_fetch)
        end
        log.section('Clean up') do
          label_to_fetch.delete_if_exist?(client)
        end
      end

    end

  end

end