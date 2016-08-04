class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {:name => "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {:name => "Sailboat"}).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {:name => "Motorboat"}).uniq
  end

  def self.talented_seamen
    # includes(boats: :classifications).where({:classifications => {:name => "Motorboat"}} && {:classifications => {:name =>'Sailboat'}})
    t_s = sailors & motorboat_operators
    where(id: t_s.map(&:id))
  end

  def self.non_sailors
    # includes(boats: :classifications).except(classifications: {:name => "Sailboat"})
    n_s = all - sailors
    where(id: n_s.map(&:id))
  end
end
