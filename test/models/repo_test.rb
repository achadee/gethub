require 'test_helper'

class RepoTest < ActiveSupport::TestCase

  test "test that all attributes are readable" do
    r = Repo.new(id: 1, name: "new repo", full_name: "some name", html_url: "http://...", user_name: "avin")
    assert_not r.id.nil?
    assert_not r.name.nil?
    assert_not r.full_name.nil?
    assert_not r.html_url.nil?
    assert_not r.user_name.nil?
  end

  test "non string value passed to search function" do
    r = Repo.search({})
    assert_equal(r[:count], 0)
  end

  test "valid search result" do
    r = Repo.search("code")
    assert r[:count] > 0
    r1= r[:repos].first

    # checks to see that all the fields have been filled in the repo object
    assert_not r1.id.nil?
    assert_not r1.name.nil?
    assert_not r1.full_name.nil?
    assert_not r1.html_url.nil?
    assert_not r1.user_name.nil?
  end

end
