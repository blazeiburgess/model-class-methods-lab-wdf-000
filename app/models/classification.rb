class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.longest
    joins(:boats).order('length DESC').limit(2)
  end

  def self.my_all
    uniq
  end
end
