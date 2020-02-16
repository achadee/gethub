#
# just need to use a non active record class because we arnt persisting anything
#

class Repo

  # set attributes to be visible for future development
  #
  attr_reader :id
  attr_reader :name
  attr_reader :full_name
  attr_reader :user_name
  attr_reader :html_url

  def initialize **args

    # start the object with nil values
    #
    @id = nil
    @name = nil
    @full_name = nil
    @user_name = nil
    @html_url = nil

    # add sttributes here
    #
    args and args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  # calls the api to search based on the keyword
  #
  def self.search keyword
    return {repos: [], count: 0} unless keyword.is_a? String
    # run the request
    #
    response = Typhoeus.get("https://api.github.com/search/repositories", params: { q: keyword })

    # parse the response
    #
    parse_response response, {to_hash: true}
  end

  def self.parse_response response, options={}
    # if there was an error in the response just return an empty array
    #
    return {repos: [], count: 0} if response.code != 200

    # if the body is not a string return empty array
    #
    return {repos: [], count: 0} unless response.body.is_a? String

    # parse response and return results
    #
    begin
      json_body = JSON.parse(response.body)
    rescue JSON::ParserError => e
      # return an empty array if there is a json parsing error
      #
      return {repos: [], count: 0}
    end

    # create a bunch of repo objects
    #
    repos = json_body["items"].map{|item| Repo.new(
      id: item["id"],
      name: item["name"],
      full_name: item["full_name"],
      user_name: item["owner"]["login"],
      html_url: item["html_url"]
    )}

    return {repos: repos, count: json_body["total_count"]}
  end
end
