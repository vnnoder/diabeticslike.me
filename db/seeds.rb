require 'database_cleaner'
DatabaseCleaner[:active_record].clean_with :truncation

