require_relative '../../base_classes/endpoints/base_class_for_put_id'

require_relative '../../../rest_api/data/user'

class PutUsersId < BaseClassForPutId

  Contract ExampleRestClient, User => [User, Any]
  def self.call_and_return_payload(client, user)
    super
  end

  Contract ExampleRestClient, Log, VERDICT_ID, User => User
  def self.verdict_call_and_verify_success(client, log, verdict_id, user_to_put)
    super
  end

end
