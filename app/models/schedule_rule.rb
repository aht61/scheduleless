class ScheduleRule < ApplicationRecord
  belongs_to :company
  belongs_to :position

  validates :period, presence: true, uniqueness: { scope: :position }

  enum period: {
    open: 0,
    close: 1,
    all_day: 2,
    lull: 3,
    normal: 4,
    busy: 5,
    peak: 6
  }

  def self.collection_labels
    self.periods.keys.map do |key|
      [I18n.t("models.schedule_rule.#{key}") ,key]
    end
  end
end