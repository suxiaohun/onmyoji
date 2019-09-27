module EsBook
  extend ActiveSupport::Concern

  included do
    self.__elasticsearch__.client = ES_BOOK_CLIENT

    after_commit :update_es_index_async, on: [:create, :update]

    # mapping dynamic: 'strict' do
    #   indexes :id, type: :integer
    #   indexes :name, type: :keyword
    # end

    # settings index: { number_of_shards: 1 } do
    #   mappings dynamic: 'false' do
    #     indexes :id, type: :integer
    #     indexes :name, type: :keyword
    #   end
    # end

    settings index: {number_of_shards: 1} do
      mapping dynamic: false do
        indexes :id, type: :integer
        indexes :name, type: :keyword
        indexes :category, type: :keyword
      end
    end


    # settings(number_of_shards: 1) do
    #   mappings dynamic: false do
    #     indexes :id, type: :integer
    #     indexes :name, type: :keyword
    #   end
    # end

    # mapping dynamic: 'strict' do
    #   indexes :name, type: :keyword
    # end
    # self.mapping(dynamic: 'strict') { indexes :id, type: 'long' }
  end

  def as_indexed_json(options = {})
    db_columns = []
    db_columns << :id
    db_columns << :name

    hash = as_json(only: db_columns, methods: [])
    hash.merge extra_fields_for_es
  end

  def extra_fields_for_es
    {
        category: category.name
    }
  end


  def update_index
    __elasticsearch__.index_document
    true
  end

  def destory_index
    __elasticsearch__.delete_document
    true
  end

  def update_es_index_async
    EsUpdateBookJob.perform_later self.id
  end

end