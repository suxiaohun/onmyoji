require 'elasticsearch/model'
class Book < ApplicationRecord
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks


  belongs_to :author
  belongs_to :category


  def self.search_filter(name)
    query = {
        "query": {
            "match_all": {}
        }}
    if name.present?

      query = {
          "query": {
              "wildcard": {"name": '*'+name+'*'}
          }
      }


      # query = {
      #     "query": {
      #         "bool": {
      #             "must": {
      #                 "term": {
      #                     "name": name
      #                 }
      #             }
      #         }
      #
      #     }}
    end

    # response = __elasticsearch__.search({"from":3,"size":1})
    response = __elasticsearch__.search(query)
  end


  # mapping dynamic: 'strict' do
  #   indexes :name, type: :keyword
  # end

  #
  # def self.search(param)
  #   record = __elasticsearch__.search
  # end


  # binding.pry
  # Delete the previous articles index in Elasticsearch
  # Book.__elasticsearch__.client.indices.delete index: Book.index_name rescue nil
  #
  # # Create the new index with the new mapping
  # Book.__elasticsearch__.client.indices.create(
  #     index: Book.index_name,
  #     body: {settings: Book.settings.to_hash,
  #            mappings: Book.mappings.to_hash}
  # )
  #
  # # Index all article records from the DB to Elasticsearch
  # Book.import force: true

  # Book.__elasticsearch__.delete_index!
  #
  # Book.__elasticsearch__.create_index!


end
