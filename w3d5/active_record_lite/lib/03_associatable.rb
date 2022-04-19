require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def foreign_key
    if self.class == BelongsToOptions
      @options[:foreign_key] ||= (@name.underscore + '_id').to_sym
    else
      @options[:foreign_key] ||= (@self_class_name.underscore + '_id').to_sym
    end
  end

  def primary_key
    @options[:primary_key] ||= :id
  end

  def class_name
    @options[:class_name] ||= @name.camelcase.singularize
  end

  def model_class
    class_name.constantize
  end

  def table_name
    name = @name.underscore
    name.end_with?('s') ? name : name + 's'
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @name = name.to_s
    @options = options
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @name = name.to_s
    @self_class_name = self_class_name.to_s
    @options = options
  end
end

module Associatable
  # Everything is built off the name given
  def belongs_to(name, options = {})
      options = BelongsToOptions.new(name, options)
      assoc_options[name] = options
      define_method(name) {
        fk = send(options.foreign_key)
        pk = options.primary_key
        other_class = options.model_class
        other_class.send(:where, { pk => fk }).first
      }
  end

  def has_many(name, options = {})
      options = HasManyOptions.new(name, self, options)
      define_method(name) {
        fk = options.foreign_key
        pk = send(options.primary_key)
        other_class = options.model_class
        other_class.send(:where, { fk => pk})
      }
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
