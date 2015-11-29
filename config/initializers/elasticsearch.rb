
# https://github.com/elastic/elasticsearch-ruby/tree/master/elasticsearch-transport#setting-hosts
Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: ENV['ELASTICSEARCH_URL'],
  # log: true
)
