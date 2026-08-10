class EventsController < ApplicationController
  before_action :set_event, only: [ :edit, :update, :destroy ]
  def index
    @events = current_user.events.order(created_at: :desc)
  end

  def new
    @event = current_user.events.build
    prepare_event_schedules
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to events_path
    else
      prepare_event_schedules
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    prepare_event_schedules
  end

  def update
    if @event.update(event_params)
      redirect_to events_path
    else
      prepare_event_schedules
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!
    redirect_to events_path, status: :see_other
  end

  private

  def set_event
    @event = current_user.events.find(params[:id])
  end

  def prepare_event_schedules
    remaining_count = [ 10 - @event.event_schedules.size, 0 ].max
    remaining_count.times { @event.event_schedules.build }
  end

  def event_params
    params.require(:event).permit(:name, :description, :address, :event_image, :event_image_cache, event_schedules_attributes: %i[id event_date _destroy ])
  end
end
