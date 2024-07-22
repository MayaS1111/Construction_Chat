# == Schema Information
#
# Table name: chats
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer          not null
#
# Indexes
#
#  index_chats_on_project_id  (project_id)
#
# Foreign Keys
#
#  project_id  (project_id => projects.id)
#
class Chat < ApplicationRecord
  belongs_to :project
  has_many :users, class_name: "User", foreign_key: "user_id" 

end
