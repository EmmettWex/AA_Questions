require_relative 'QuestionsDatabase'

class Questions

    attr_accessor :id, :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Questions.new(datum) }
    end


    #looks up an id in a table and returns an object representing that row
    #returns a questions
    #contains a questions.new
    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          questions
        WHERE
          id = ?
        SQL
            # "SELECT * FROM questions WHERE id = #{id}")
        Questions.new(data[0])
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

end