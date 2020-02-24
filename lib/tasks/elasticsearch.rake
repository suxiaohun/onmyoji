namespace :elasticsearch do
  desc "TODO"
  task create_index: :environment do
    class_name = ENV["class"]
    binding.pry
    raise '必须指定class参数' unless  class_name.present?
    class_name = class_name.camelize
    object = class_name.constantize
    real_index_name = object.table_name

    object.__elasticsearch__.create_index! index: real_index_name, force: true
    #object.__elasticsearch__.refresh_index! index: real_index_name

  end

end
