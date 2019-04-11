require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:priyank).id,
                                     followed_id: users(:archer).id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
   test "should follow and unfollow a user" do
    priyank = users(:priyank)
    archer  = users(:archer)
    assert_not priyank.following?(archer)
    priyank.follow(archer)
    assert priyank.following?(archer)
    assert archer.followers.include?(priyank)
    priyank.unfollow(archer)
    assert_not priyank.following?(archer)
  end
end
