module Remote
  module InProgressShifts
    class DeleteConfirmationsController < AuthenticatedController
      include StatefulParams

      helper_method :presenter_class

      def create
        @shift = InProgressShift.find_by!(id: params[:in_progress_shift_id],
                                          company_id: current_company.id)
        authorize @shift

        @confirmation = ::InProgressShifts::DeleteConfirmation.
          new(delete_confirmation_params)

        @confirmation.process
      end

      def new
        shift = InProgressShift.find_by!(id: params[:in_progress_shift_id],
                                          company_id: current_company.id)

        authorize shift

        @confirmation = ::InProgressShifts::DeleteConfirmation.
          new({ in_progress_shift_id: shift.id })
      end

      private

      def delete_confirmation_params
        params.
          require(:in_progress_shifts_delete_confirmation).
          permit(:in_progress_shift_id, :delete_series)
      end

      def presenter_class
        if view == "daily"
          ::Calendar::DailySchedulePresenter
        else
          ::Calendar::WeeklySchedulePresenter
        end
      end
    end
  end
end
