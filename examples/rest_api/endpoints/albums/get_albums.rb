require_relative '../base_classes/base_class_for_get'

require_relative '../../../rest_api/data/album'
require_relative '../../../../test/assertion_helper'

class GetAlbums < BaseClassForGet

  Contract ExampleRestClient => [ArrayOf[Any], Any]
  def self.call_and_return_payload(client)
    super(client)
  end

  Contract ExampleRestClient, Log, String => ArrayOf[Album]
  def self.verdict_call_and_verify_success(client, log, verdict_id)
    log.section(verdict_id, :rescue, :timestamp, :duration) do
      albums, _ = self.call_and_return_payload(client)
      album = albums.first
      album.verdict_valid?(log, verdict_id)
      return albums
    end
  end

end