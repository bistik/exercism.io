require_relative '../acceptance_helper'

class TeamAcceptanceTest < AcceptanceTestCase
  def test_joining_a_teamd
    creating_user = create_user(username: 'creating_user')
    joining_user = create_user(username: 'joining_user', github_id: 123)

    Team.by(creating_user).defined_with(slug: 'some-team',
                                        name: 'Some Name',
                                        usernames: 'joining_user')
        .save!

    with_login(joining_user) do
      click_on 'Account'

      assert_content 'some-team'

      click_on 'Accept invitation'

      assert_content 'Team Some Name'
      assert_content 'joining_user'
    end
  end
end
