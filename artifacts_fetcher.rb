require 'faraday'
require 'json'

class ArtifactsFetcher
  def initialize(user, project, token)
    @user = user
    @project = project
    @token = token
  end

  def coverage_shield_url(branch)
    url = artifacts_url branch
    build_artifacts = artifacts_info url
    shield_artifact = build_artifacts.select { |art| art["pretty_path"]&.match(/coverage\.svg/) }.first
    shield_artifact["url"]
  end

  private

  def artifacts_info(url)
    response = Faraday.get url
    JSON.parse response.body
  end


  def artifacts_url(branch)
    "https://circleci.com/api/v1.1/project/github/#{@user}/#{@project}/latest/artifacts?circle-token=#{@token}&branch=#{branch}"
  end
end
