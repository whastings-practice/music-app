# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  album_id   :integer          not null
#  bonus      :boolean          default(FALSE), not null
#  lyrics     :text
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  validates :name, :album_id, presence: true
  validates :bonus, inclusion: { in: [true, false] }

  belongs_to :album
  has_one :band, through: :album

  def bonus?
    self.bonus
  end
end
