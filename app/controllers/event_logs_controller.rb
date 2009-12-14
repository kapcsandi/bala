class EventLogsController < ApplicationController
  before_filter :authorize
  def index
    search = EventLog.searchlogic
    @logs, @logs_count = search.all, search.count
  end
end
