require_relative 'QuestionsDatabase'

class Replies

    attr_accessor :id, :question_id, :parent_reply_id, :user_id, :body

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map { |datum| Replies.new(datum) }
    end


    #looks up an id in a table and returns an object representing that row
    #returns a questions
    #contains a questions.new
    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          replies
        WHERE
          id = ?
        SQL
            # "SELECT * FROM replies WHERE id = #{id}")
        Replies.new(data[0])
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @user_id = options['user_id']
        @body = options['body']
    end

    
end