# frozen_string_literal: true

module ApplicationHelper
  def localized_check_state(state)
    I18n.t("activerecord.attributes.check.states.#{state}")
  end
end
