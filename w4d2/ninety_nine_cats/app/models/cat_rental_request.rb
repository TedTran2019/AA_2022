# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord
  validates :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w[PENDING APPROVED DENIED] }
  validate :does_not_overlap_approved_request

  belongs_to :cat

  def overlapping_requests
    CatRentalRequest
    .where('cat_id = ?', cat_id)
    .where.not('(start_date < ? AND end_date < ?) OR
                (start_date > ? AND end_date > ?)', start_date, start_date,
                                                    end_date, end_date)
  end

  def overlapping_approved_requests
    overlapping_requests
    .where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests
    .where("status = 'PENDING'")
  end

  def approve!
    ActiveRecord::Base.transaction do 
      self.status = 'APPROVED'
      self.save
      overlapping_pending_requests.each do |pending_request|
        pending_request.deny!
      end
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.any? { |request| CatRentalRequest.exists?(request.id)}
      errors.add(:request, 'Overlapping rental periods!')
    end
  end
end
