require 'json'
require 'rest-client'
require 'retriable'
require 'uri'

require_relative '../../lib/base_classes/base_class'

class GithubClient < BaseClass
  
  # Instantiate a client for the caller's block.
  Contract Log, String, String, String, Proc => nil
  def self.with(log, repo_username, repo_password, repo_name)
    raise 'No block given' unless (block_given?)
    log.section('With %s' % self, :rescue) do
      client = self.new(log, repo_username, repo_password, repo_name, im_ok_youre_not_ok = true)
      # Client should retrieve and log the API version if it's available.
      # (Here, it's not.)
      yield client
      # Client should calculate and log summary information here.
      # TBS.
    end
    nil
  end

  def initialize(log, repo_username, repo_password, repo_name, im_ok_youre_not_ok = false)
    raise RuntimeError('Call method with, not new') unless im_ok_youre_not_ok
    @repo_username = repo_username
    @repo_password = repo_password
    @repo_name = repo_name
    @base_url = 'https://api.github.com'
    @uri = URI.parse(@base_url)
    @log = log
  end

  def repo_url_elements
    [
        'repos',
        @repo_username,
        @repo_name,
    ]
  end

  # Get.
  Contract Array, Maybe[Hash] => Or[Array, Hash]
  def get(url_elements, query_elements = {})
    client_method(__method__, url_elements, query_elements, parameters = {})
  end

  # Post.
  Contract Array, Hash => Hash
  def post(url_elements, parameters)
    client_method(__method__, url_elements, query_elements = {}, parameters)
  end

  # Put.
  Contract Array, Hash => Hash
  def put(url_elements, parameters)
    client_method(__method__, url_elements, query_elements = {}, parameters)
  end

  # Delete.
  Contract Array => Hash
  def delete(url_elements)
    client_method(__method__, url_elements, query_elements = {}, parameters = {})
  end

  private

  # Do one of the above.
  Contract Symbol, Array, Hash, Hash => Or[String, Array, Hash]
  def client_method(rest_method, url_elements, query_elements, parameters)
    url = File.join(@base_url, *url_elements)
    query_elements.to_a.each_with_index do |pair, i|
      char = (i == 0) ? '?' : '&'
      url += '%s%s=%s' % [char, *pair]
    end
    url = URI.escape(url)
    args = Hash.new
    args.store(:method, rest_method)
    args.store(:url, url)
    args.store(:user, @repo_username)
    args.store(:password, @repo_password)
    case
      when [
          :delete,
          :get
      ].include?(rest_method)
      when [
          :post,
          :put
      ].include?(rest_method)
        headers = {
            :content_type => 'application/json',
        }

        parameters_json = parameters.to_json
        args.store(:payload, parameters_json)
        args.store(:headers, headers)
      else
        raise ArgumentError(rest_method)
    end

    args.store(:timeout, 60)

    log_retry = Proc.new do |exception, try, elapsed_time, next_interval|
      puts "#{exception.class}: '#{exception.message}'"
      puts "#{try} tries in #{elapsed_time} seconds and #{next_interval} seconds until the next try."
    end

    response = nil
    @log.put_element(self.class.name, :method => rest_method.to_s.upcase, :url => url) do
      @log.put_element('parameters', parameters) unless parameters.empty?
      @log.put_element('execution', :timestamp, :duration) do
        # noinspection RubyResolve
        Retriable.retriable on: RestClient::RequestTimeout, tries: 10, base_interval: 1, on_retry: log_retry do
          p args
          response = RestClient::Request.execute(args)
        end
      end
    end
    # RubyMine inspection thinks this should have no argument.
    # noinspection RubyArgCount
    parser = JSON::Ext::Parser.new(response)
    parser.parse
  end

end

=begin
The simple class is label.  See /labels/bug.
Mid is rate_limits.  Some nesting.
=end

#
# client = GithubClient.new
# # p client.get(['repos', 'octokit', 'octokit.rb'])
# # p client.get(['repos', 'BurdetteLamar', 'CrashDummy'])
# p client.get(['repos', 'BurdetteLamar', 'CrashDummy', 'labels', 'bug'])
# parameters = {
#     "message": "my commit message",
#     "content": "bXkgbmV3IGZpbGUgY29udGVudHM=",
#     "sha": "0d5a690c8fad5e605a6e8766295d9d459d65de42",
# }
#
# # p client.put(['repos', 'BurdetteLamar', 'CrashDummy', 'contents', 'Tour2.md'], parameters)
# # PUT /repos/:owner/:repo/contents/:path
#
# # p client.get(['rate_limit'])
#
# =begin
# GET    /repos/:owner/:repo/issues/comments/:id
# POST   /repos/:owner/:repo/issues/:number/comments
# PATCH  /repos/:owner/:repo/issues/comments/:id
# DELETE /repos/:owner/:repo/issues/comments/:id
#
# List comments on an issue?
# GET    /repos/:owner/:repo/issues/:number/comments
# List comments in a repository?
# GET /repos/:owner/:repo/issues/comments
#
# =end
#
# # PUT works when it's a create for new file, fails if file exists.
# {
#     "content": {
#         "name": "hello.txt",
#         "path": "notes/hello.txt",
#         "sha": "95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
#         "size": 9,
#         "url": "https://api.github.com/repos/octocat/Hello-World/contents/notes/hello.txt",
#         "html_url": "https://github.com/octocat/Hello-World/blob/master/notes/hello.txt",
#         "git_url": "https://api.github.com/repos/octocat/Hello-World/git/blobs/95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
#         "download_url": "https://raw.githubusercontent.com/octocat/HelloWorld/master/notes/hello.txt",
#         "type": "file",
#         "_links": {
#             "self": "https://api.github.com/repos/octocat/Hello-World/contents/notes/hello.txt",
#             "git": "https://api.github.com/repos/octocat/Hello-World/git/blobs/95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
#             "html": "https://github.com/octocat/Hello-World/blob/master/notes/hello.txt"
#         }
#     },
#     "commit": {
#         "sha": "7638417db6d59f3c431d3e1f261cc637155684cd",
#         "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
#         "html_url": "https://github.com/octocat/Hello-World/git/commit/7638417db6d59f3c431d3e1f261cc637155684cd",
#         "author": {
#             "date": "2014-11-07T22:01:45Z",
#             "name": "Scott Chacon",
#             "email": "schacon@gmail.com"
#         },
#         "committer": {
#             "date": "2014-11-07T22:01:45Z",
#             "name": "Scott Chacon",
#             "email": "schacon@gmail.com"
#         },
#         "message": "my commit message",
#         "tree": {
#             "url": "https://api.github.com/repos/octocat/Hello-World/git/trees/691272480426f78a0138979dd3ce63b77f706feb",
#             "sha": "691272480426f78a0138979dd3ce63b77f706feb"
#         },
#         "parents": [
#             {
#                 "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/1acc419d4d6a9ce985db7be48c6349a0475975b5",
#                 "html_url": "https://github.com/octocat/Hello-World/git/commit/1acc419d4d6a9ce985db7be48c6349a0475975b5",
#                 "sha": "1acc419d4d6a9ce985db7be48c6349a0475975b5"
#             }
#         ]
#     }
# }
