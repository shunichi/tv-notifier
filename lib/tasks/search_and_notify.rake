namespace :tv_notifier do
  task search_and_notify: :environment do
    SearchKeyword.find_each do |search_keyword|
      search_keyword.search_and_notify
    end
  end
end