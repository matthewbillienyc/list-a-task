class CreateListServices
  attr_reader :list

  def initialize(list)
    @list = list
  end

  def call
    list.user.lists_total += 1
    list.user.save
  end
end
