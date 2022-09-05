module UsersHelper
  def dogcase(user)
    "@#{user.nickname}"
  end
end
