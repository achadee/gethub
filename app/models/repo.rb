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

  def initialize **args

    # start the object with nil values
    #
    @id = nil
    @name = nil
    @full_name = nil
    @user_name = nil

    # add sttributes here
    #
    args and args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  # calls the api to search based on the keyword
  #
  def self.search keyword

    # run the request
    #
    request = Typhoeus.get("https://api.github.com/search/repositories", params: { q: q })
    request.run

    # get the response
    #
    response = query(keyword)

    # parse the response and return repo collection
    #
    parse_response(request.response)
  end
end
