module Tanker

  class << self        
    protected
    
    def instantiate_results_from_db(index_result)
      results = index_result['results']
      return [] if results.empty?

      id_map = results.inject({}) do |acc, result|
        model = result["__type"]
        id = constantize(model).tanker_parse_doc_id(result)
        acc[model] ||= []
        acc[model] << id
        acc
      end

      id_map.each do |klass, ids|
        # BEGIN MY PATCH
        # narrow ids down to records that exist 
        # ids = ids.find_all {|x| constantize(klass).exists? x}
        # END MY PATCH
        
        # replace the id list with an eager-loaded list of records for this model
        klass_const = constantize(klass)
        if klass_const.respond_to?('find_all_by_id') 
          id_map[klass] = klass_const.find_all_by_id(ids)
        else
          id_map[klass] = klass_const.find(ids)
        end  
      end
      # return them in order
      results = results.map do |result|
        model, id = result["__type"], result["__id"]
        id_map[model].detect {|record| id == record.id.to_s }
      end
      results.compact
    end
  end
end