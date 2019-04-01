# frozen_string_literal: true

# == Schema Information
#
# Table name: build_results
#
#  id                :uuid             not null, primary key
#  duration          :interval
#  manual            :boolean          default(FALSE)
#  openstack_release :text
#  passed            :boolean
#  ran_at            :datetime
#  ubuntu_release    :text
#  url               :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  build_id          :uuid
#  user_id           :uuid
#
# Indexes
#
#  index_build_results_on_build_id  (build_id)
#  index_build_results_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (build_id => builds.id)
#  fk_rails_...  (user_id => users.id)
#

class BuildResult < ApplicationRecord
  belongs_to :build

  scope :recent_build_results, -> { where('ran_at > ?', 90.days.ago) }

  def uos
    "#{ubuntu_release}-#{openstack_release}"
  end

  def duration
    interval_from_db = super
    time_parts = interval_from_db.split(':')
    if time_parts.size > 1 # Handle formats like 17:04:41.478432
      units = %i[hours minutes seconds]
      in_seconds = time_parts
                   .map.with_index { |t, i| t.to_i.public_send(units[i]) }
                   .reduce(&:+) # Turn each part to seconds and then sum
      ActiveSupport::Duration.build in_seconds
    else # Handle formats in seconds
      ActiveSupport::Duration.build(interval_from_db.to_i)
    end
  end
end
