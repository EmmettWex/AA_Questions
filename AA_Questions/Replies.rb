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

    def self.find_by_user_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
          *
        FROM
          replies
        WHERE
          user_id = ?
        SQL
            # "SELECT * FROM replies WHERE id = #{id}")
        data.map { |datum| Replies.new(datum) }
    end

    def self.find_by_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          *
        FROM
          replies
        WHERE
          question_id = ?
        SQL
            # "SELECT * FROM replies WHERE id = #{id}")
        data.map { |datum| Replies.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @user_id = options['user_id']
        @body = options['body']
    end

    def author
        Users.find_by_id(@user_id)
    end

    def question
        Questions.find_by_question_id(@question_id)
    end

    def parent_reply
        Replies.find_by_id(@parent_reply_id)
    end

    def child_replies
        data = QuestionsDatabase.instance.execute(<<-SQL, @id)
        
        SELECT
          *
        FROM
          replies
        WHERE
          parent_reply_id = ?
        SQL

        data.map { |datum| Replies.new(datum) }
    end
end