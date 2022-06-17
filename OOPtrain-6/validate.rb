module Validate
  def valid?
    validate!
    true
  rescue StandardError => e
    false
  end
end