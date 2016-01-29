class CreateListServices
  attr_reader :list

  def initialize(list)
    @list = list
  end

  def call
    user = User.find(list.user_id)
    user.lists_total += 1
    user.save
  end
end
