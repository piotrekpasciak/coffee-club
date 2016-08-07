# == Schema Information
#
# Table name: user_achievements
#
#  id             :integer          not null, primary key
#  shown          :boolean          default(FALSE)
#  user_id        :integer          not null
#  achievement_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'
