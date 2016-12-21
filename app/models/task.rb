class Task < ApplicationRecord
  belongs_to :list
  after_create :increment_counter
  after_destroy :decrement_counter
  validates :title, presence: true,
                    length: { minimum: 3 },
                    uniqueness: { scope: :list_id }

  scope :filtered, ->(type) { send(type) if type }
  scope :done, -> { where(done: true) }
  scope :open, -> { where(done: false) }

  private

  def increment_counter
    self.list.increment_counter!
  end

  def decrement_counter
    self.list.decrement_counter!
  end
end
