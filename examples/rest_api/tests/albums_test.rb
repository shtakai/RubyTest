require_relative '../base_classes/base_class_for_test'

require_relative '../endpoints/albums/delete_albums_id'
require_relative '../endpoints/albums/get_albums'
require_relative '../endpoints/albums/get_albums_id'
require_relative '../endpoints/albums/post_albums'
require_relative '../endpoints/albums/put_albums_id'

class AlbumsTest < BaseClassForTest

  def test_delete_albums_id

    prelude do |client, log|
      log.section('Test DeleteAlbumsId') do
        album_to_delete = nil
        log.section('Get an album to delete') do
          album_to_delete = Album.get_first(client)
        end
        log.section('Delete the album') do
          DeleteAlbumsId.verdict_call_and_verify_success(client, log, :delete_album, album_to_delete)
        end
      end
    end
  end

  def test_get_albums

    prelude do |client, log|

      log.section('Test GetAlbums') do

        all_albums = nil
        log.section('GetAlbums with no query') do
          all_albums = GetAlbums.verdict_call_and_verify_success(client, log, :no_query)
        end

        log.section('GetAlbums with simple query') do
          album = all_albums.first
          query_elements = {
              :userId => album.userId,
          }
          expected_albums = all_albums.select { |p| p.userId == album.userId }
          actual_albums = GetAlbums.call(client, query_elements)
          if log.verdict_assert_equal?(:count_for_simple_query, expected_albums.size, actual_albums.size)
            (0...expected_albums.size).each do |i|
              expected_album = expected_albums[i]
              actual_album = actual_albums[i]
              v_id = format('with simple query %d', i).to_sym
              Album.verdict_equal?(log, v_id, expected_album, actual_album)
            end
          end
        end

        log.section('GetAlbums with complex query') do
          album = all_albums.first
          query_elements = {
              :userId => album.userId,
              :title => album.title,
          }
          expected_albums = all_albums.select { |p| (p.userId == album.userId) && (p.title == album.title) }
          actual_albums = GetAlbums.call(client, query_elements)
          if log.verdict_assert_equal?(:count_for_complex_query, expected_albums.size, actual_albums.size)
            (0...expected_albums.size).each do |i|
              expected_album = expected_albums[i]
              actual_album = actual_albums[i]
              v_id = format('with_complex_query_%d', i).to_sym
              Album.verdict_equal?(log, v_id, expected_album, actual_album)
            end
          end
        end

      end

    end

  end

  def test_get_albums_id

    prelude do |client, log|
      log.section('Test GetAlbumsId') do
        album_to_fetch = nil
        log.section('Get an album to fetch') do
          album_to_fetch = Album.get_first(client)
        end
        log.section('Fetch the album') do
          GetAlbumsId.verdict_call_and_verify_success(client, log, :get_album, album_to_fetch)
        end
      end
    end

  end

  def test_post_albums

    prelude do |client, log|
      log.section('Test AlbumAlbums') do
        album_to_create = Album.new(
            :id => nil,
            :userId => 1,
            :title => 'My Album',
        )
        PostAlbums.verdict_call_and_verify_success(client, log, :album_to_create, album_to_create)
      end
    end

  end

  def test_put_albums_id

    prelude do |client, log|
      log.section('Test PutAlbumsId') do
        album_to_update = nil
        log.section('Get a album to update') do
          album_original = Album.get_first(client)
          album_to_update = album_original.clone
        end
        log.section('Put the modifications') do
          album_to_update.title = 'New Title'
          PutAlbumsId.verdict_call_and_verify_success(client, log, :album_to_update, album_to_update)
        end
      end

    end

  end

end
