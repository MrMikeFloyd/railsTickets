class ClaimStatus < ApplicationRecord

  # Relationships
  has_many :claims

  # Methods for status handling

  # Returns the status object with the lowest value.
  def self.get_initial
    lowest_status = self.all.order(:value).first
  end

  # Returns the status object with the highest value.
  def self.get_terminal
    lowest_status = self.all.order(:value).last
  end

  # Returns the status object with the next higher status value. Throws exception otherwise.
  def self.get_next(value)
    next_status = self.all.where("value > ?", value).order(:value).first
    if next_status.nil?
      raise "No status available with a value higher than #{value}."
    end
    next_status
  end

  # Returns the status object with the next lower status value. Throws exception otherwise.
  def self.get_previous(value)
    previous_status = self.all.where("value < ?", value).order(:value).last
    if previous_status.nil?
      raise "No status available with a value lower than #{value}."
    end
    previous_status
  end

end
