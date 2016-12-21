class List < ApplicationRecord
  has_many :tasks, dependent: :delete_all
  has_many :pending_emails, dependent: :delete_all
  has_and_belongs_to_many :users
  belongs_to :user

  scope :for, lambda { |user|
    joins('LEFT JOIN lists_users ON lists.id = lists_users.list_id')
      .where('lists_users.user_id = :user OR lists.user_id = :user', user: user)
  }

  scope :by_pending_email, (lambda do |email|
    joins(:pending_emails)
      .where('pending_emails.email = ?', email)
  end)

  def all_users
    [user] + users
  end

  def increment_counter!
    self.update(tasks_count: self.tasks_count.next)
  end

  def decrement_counter!
    self.update(tasks_count: self.tasks_count.pred)
  end
end
