namespace :shortened_url do
  desc 'Prune old urls'
  task prune_urls: :environment do
    puts 'Pruning old urls'
    ShortenedUrl.prune(60)
  end
end