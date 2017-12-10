require_relative '../../api/base_classes/base_class_for_test'

require_relative '../../api/endpoints/labels/patch_labels_name'

class PatchLabelsNameTest < BaseClassForTest

  def test_patch_labels_name

    prelude do |log, api_client|

      log.section('Test PatchLabelsName') do
        label_to_create = Label.new(
            :id => nil,
            :url => nil,
            :name => 'test_label',
            :color => '000000',
            :default => false,
        )
        label_to_create.delete_if_exist?(api_client)
        label_to_patch = label_to_create.create(api_client)
        label_to_patch.color = 'ffffff'
        PatchLabelsName.verdict_call_and_verify_success(api_client, :patch_label, label_to_patch)
        label_to_patch.delete_if_exist?(api_client)
      end

    end

  end

end