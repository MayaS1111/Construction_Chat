# frozen_string_literal: true

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
#  status       :string
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
  validates :name, presence: true
  belongs_to :owner, class_name: 'User'
  has_many :chats, class_name: 'Chat', foreign_key: 'project_id'
  has_one :first_chat, -> { order(:created_at).limit(1) }, class_name: 'Chat'

  accepts_nested_attributes_for :chats, :owner

  scope :private_type, -> { where(project_type: 'private') }
  scope :public_type, -> { where(project_type: 'public') }


  def create_main_chat(current_user)
    chat = Chat.create(project_id: self.id, name: 'Main', description: 'This chat is for all members')
    UserChat.create(user_id: current_user.id, chat_id: chat.id)
  end
end
