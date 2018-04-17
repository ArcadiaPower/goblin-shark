require 'sqlite3'
require 'active_record'
require 'aasm'
require 'observer'
require 'annotate'
require 'pry'

ENVIRONMENT = 'test'

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Set up database tables and columns
ActiveRecord::Schema.define do
  create_table :accounts, force: true do |t|
    t.string :name
    t.timestamps
  end
  create_table :bills, force: true do |t|
    t.string :status
    t.decimal :total, precision: 19, scale: 4
    t.references :account
    t.timestamps
  end
  create_table :bill_items, force: true do |t|
    t.string :label
    t.decimal :amount, precision: 19, scale: 4
    t.string :type
    t.references :account
    t.references :bill
    t.timestamps
  end
end

Dir["#{File.dirname(__FILE__)}/models/**/*.rb"].sort.each { |f| load(f) }

if ENVIRONMENT == 'development'
  options = {}
  options[:position] = 'before'
  options[:show_foreign_keys] = 'true'
  options[:show_indexes] = 'true'
  options[:model_dir] = './models/'
  options[:exclude_sti_subclasses] = 'false'
  options[:ignore_model_sub_dir] = 'false'
  AnnotateModels.do_annotations(options)
end
