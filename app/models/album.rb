# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  band_id    :integer          not null
#  album_type :string(10)       not null
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  TYPES = ['live', 'studio']

  validates :name, :band_id, :album_type, presence: true
  validates :album_type, inclusion: { in: TYPES }

  belongs_to :band

  has_many :tracks, dependent: :destroy
end
