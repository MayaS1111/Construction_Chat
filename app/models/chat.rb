# frozen_string_literal: true

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
  validates :name, presence: true
  belongs_to :project, required: true, class_name: 'Project', foreign_key: 'project_id'
  has_many :messages, class_name: 'Message', foreign_key: 'chat_id'
  has_many :user_chats
  has_many :chats, through: :user_chats
  has_many :members, through: :user_chats, source: :user
 
  scope :private_projects, -> { joins(:project).where('projects.project_type = ?', 'private') }
  scope :public_projects, -> { joins(:project).where('projects.project_type = ?', 'public') }
  scope :with_user, ->(user) { joins(:user_chats).where('user_chats.user_id = ?', user) }
  scope :for_project, ->(project) { joins(:project).where('projects.id = ?', project) }
  scope :with_member_count, ->(count) { joins(:user_chats).group('chats.id')
                                        .having('COUNT(user_chats.user_id) = ?', count)}   
  scope :common_for_users, ->(user1, user2) { joins(:user_chats).where(user_chats: { user_id: user1.id })
                                        .where(id: Chat.joins(:user_chats)
                                        .where(user_chats: { user_id: user2.id })
                                        .select(:id))}  

  def self.filtered_common_private_chats(current_user, user)
    private_projects
      .common_for_users(current_user, user)
      .with_member_count(2)
  end   

  def private_chat(current_user, user, private_project)
    chat = Chat.new(
      description: 'nil',
      name: "#{current_user.first_name} & #{user.first_name}",
      project: private_project.first
    )
    UserChat.create(chat:, user: current_user)
    UserChat.create(chat:, user:)
    chat
  end
end
