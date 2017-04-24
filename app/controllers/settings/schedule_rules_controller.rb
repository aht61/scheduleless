module Settings
  class ScheduleRulesController < AuthenticatedController
    def index
      @schedule_rules = policy_scope ScheduleRule
      @schedule_rule = ScheduleRule.new
    end

    def create
      authorize ScheduleRule

      @schedule_rule = current_company.
        schedule_rules.
        build(schedule_rule_params)

      if @schedule_rule.save
        redirect_to settings_schedule_rules_path
      else
        @schedule_rules = policy_scope ScheduleRule
        render :index
        # TODO: Handle Error
      end
    end

    private

    def schedule_rule_params
      params.
        require(:schedule_rule).
        permit(:number_of_employees, :period, :position_id)
    end
  end
end