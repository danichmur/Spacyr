class EventsController < ApplicationController
  include Math
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  def search
    longitude = params[:longitude].to_i
    latitude = params[:latitude].to_i
    pi = 3.14159265359

    cur_cos_lat = cos(latitude * pi / 180)
    cur_sin_lat = sin(latitude * pi / 180)
    cur_cos_lng = cos(longitude * pi / 180)
    cur_sin_lng = sin(longitude * pi / 180)
    cos_allowed_distance = cos(10.0 / 6371) # This is 10km


    sql = "#{cur_sin_lat} * sin_lat
      + #{cur_cos_lat} * cos_lat * cos_lng * (#{cur_cos_lng}
      + sin_lng * #{cur_sin_lng}) > #{cos_allowed_distance}";

    @events = Event.select([:id, :name, :latitude, :longitude, :description, :image_url]).where(sql)

    respond_to do |format|
      format.html
      format.json { render json: @events }
    end
  end
  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.cos_lat = cos(@event.latitude * PI / 180)
    @event.sin_lat = sin(@event.latitude * PI / 180)
    @event.cos_lng = cos(@event.longitude * PI / 180)
    @event.sin_lng = sin(@event.longitude * PI / 180)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.'}
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :latitude, :longitude, :description, :kind, :image_url)
    end
end
