class EventsController < ApplicationController
  def index
  end

  def new
    @event = current_user.events.build
    2.times { @event.event_schedules.build }
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :address, event_schedules_attributes: [ :event_date ])
  end
end
