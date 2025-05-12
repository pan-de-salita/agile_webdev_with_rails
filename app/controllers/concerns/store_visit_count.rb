module StoreVisitCount
  private

  def set_store_visit_count
    session[:counter] = session[:counter].nil? ? 1 : session[:counter] + 1
    @store_visit_count = session[:counter]
    puts 'COUNT'
    puts session[:counter]
    puts 'COUNT'
  end

  def reset_store_visit_count
    session[:counter] = nil
    @store_visit_count = nil
    puts 'COUNT'
    puts session[:counter]
    puts 'COUNT'
  end
end
