require_relative 'base_class_for_test'

require_relative '../endpoints/users/delete_users_id'
require_relative '../endpoints/users/get_users'
require_relative '../endpoints/users/get_users_id'
require_relative '../endpoints/users/post_users'
require_relative '../endpoints/users/put_users_id'

require_relative '../data/user'
require_relative '../../../lib/log/log'

class UsersTest < BaseClassForTest

  def test_delete_users_id

    prelude do |client, log|
      log.section('Test DeleteUsers') do
        user_to_delete = nil
        log.section('Get a user to delete') do
          user_to_delete = User.get_first(client)
        end
        log.section('Delete the user') do
          # This should fail, because JSONplaceholder will not actually delete the user.
          DeleteUsersId.verdict_call_and_verify_success(client, log, 'delete user', user_to_delete)
        end
      end
    end
  end

  def test_get_users

    prelude do |client, log|
      log.section('Test GetUsers') do
        GetUsers.verdict_call_and_verify_success(client, log, 'get users')
      end
    end

  end

  def test_get_users_id

    prelude do |client, log|
      log.section('Test GetUsersId') do
        user_to_fetch = nil
        log.section('Get a user to fetch') do
          user_to_fetch = User.get_first(client)
        end
        log.section('Fetch the user') do
          GetUsersId.verdict_call_and_verify_success(client, log, 'get user', user_to_fetch)
        end
      end
    end

  end

  def test_post_users

    prelude do |client, log|
      log.section('Test PostUsers') do
        user_to_post = User.new(
            :id => 1,
            :name => 'New name',
            :username => 'NewUsername',
            :email => 'New@Email.com',
            :address => {
                :street => 'New Street',
                :suite => 'New Suite',
                :city => 'New City',
                :zipcode => '55555-5555',
                :geo => {
                    :lat => '0.0',
                    :lng => '0.0'
                }
            },
            :phone => '1-555-555-5555 x55',
            :website => 'NewWebsite.org',
            :company => {
                :name => 'New Company Name',
                :catchPhrase => 'New catchphrase',
                :bs => 'New BS'
            }
        )
        # This should fail, because JSONplaceholder will not actually create the user.
        PostUsers.verdict_call_and_verify_success(client, log, 'user to_create', user_to_post)
      end
    end

  end

  def test_put_users_id

    prelude do |client, log|
      log.section('Test PutUsers') do
        user_existing = User.get_first(client)
        log.section('Put the modifications') do
          user_to_put = User.new(
              :id => user_existing.id,
              :name => 'New name',
              :username => 'NewUsername',
              :email => 'New@Email.com',
              :address => {
                  :street => 'New Street',
                  :suite => 'New Suite',
                  :city => 'New City',
                  :zipcode => '55555-5555',
                  :geo => {
                      :lat => '0.0',
                      :lng => '0.0'
                  }
              },
              :phone => '1-555-555-5555 x55',
              :website => 'NewWebsite.org',
              :company => {
                  :name => 'New Company Name',
                  :catchPhrase => 'New catchphrase',
                  :bs => 'New BS'
              }
          )
          user_to_put.name = 'New name'
          # This should fail, because JSONplaceholder will not actually update the user.
          PutUsersId.verdict_call_and_verify_success(client, log, 'User to put', user_to_put)
        end
      end

    end

  end

end

