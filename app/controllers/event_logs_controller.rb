class EventLogsController < ApplicationController
  before_filter :authorize
  def index
    search = EventLog.searchlogic
    @event_logs, @event_logs_count = search.all.paginate(:page => params[:page], :per_page => 25), search.count
  end
end
