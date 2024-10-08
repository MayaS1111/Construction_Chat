# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  job_title              :string
#  last_name              :string
#  phone_number           :string
#  profile_image          :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  employee_id            :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, class_name: 'Project', foreign_key: 'owner_id'
  has_many :messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :user_chats, class_name: 'UserChat', foreign_key: 'user_id', dependent: :destroy
  has_many :chats, through: :user_chats
  has_one :direct_message_project, -> { order(:created_at).limit(1) }, class_name: 'Project', foreign_key: 'owner_id'

  scope :non_bot, -> { where.not(id: 0) }

  def name
    "#{first_name} #{last_name}"
  end
end
