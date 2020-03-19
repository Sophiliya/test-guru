class GitHubClient
  ACCESS_TOKEN  = ENV['GITHUB_ACCESS_TOKEN']

  attr_reader :http_client

  def initialize
    @http_client = setup_octokit_client
  end

  def create_gist(params)
    @http_client.create_gist(params)
  end

  private

  def setup_octokit_client
    Octokit::Client.new(:access_token => ACCESS_TOKEN)
  end
end