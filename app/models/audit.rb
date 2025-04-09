class Audit < ApplicationRecord
  belongs_to :startup,
             class_name: "EspaceMembre::Startup",
             foreign_key: :startup_uuid,
             primary_key: :uuid

  def self.latest
    @latest ||= YAML.safe_load_file(Rails.root.join("config/standards-beta.yml"))
  end

  def initialize_data
    # Only initialize if data is blank
    return unless self.data.blank?

    self.data = {}

    standards = self.class.latest
    standards.each do |category, items|
      self.data[category] = {}
      items.each do |item|
        item["criteria"].each_with_index do |criterion, idx|
          criterion_id = "#{item['id']}_#{idx}"
          self.data[category][criterion_id] = { "status" => false }
        end
      end
    end

    # Don't save here, let the controller handle saving
  end

  def update_criterion_status(category, criterion_id, status)
    logger.debug "updating #{category}, with #{criterion_id} and status: #{status}"
    self.data ||= {}
    self.data[category] ||= {}
    self.data[category][criterion_id] ||= {}
    self.data[category][criterion_id]["status"] = status

    save
  end

  def criterion_status(category, criterion_id)
    return false unless data && data[category] && data[category][criterion_id]
    data[category][criterion_id]["status"] == "1"
  end
end
