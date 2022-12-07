require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Databaase
    include singleton

    def initialize
        super('import_db.sql')
    end
end