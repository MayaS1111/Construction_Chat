# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  description  :text
#  location     :string
#  member_count :integer          default(0)
#  name         :string
#  project_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  owner_id     :integer          not null
#
# Indexes
#
#  index_projects_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  owner_id  (owner_id => users.id)
#
class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :chats, class_name: "Chat", foreign_key: "project_id"
end
