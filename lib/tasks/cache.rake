namespace :cache do
  desc "Clear cache"
  task :clear do
    Rails.cache.clear
  end
end
