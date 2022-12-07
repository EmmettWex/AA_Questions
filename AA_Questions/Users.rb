require_relative 'QuestionsDatabase'
require_relative 'Questions'
require_relative 'Replies'
require_relative 'QuestionFollow'
class Users

    attr_accessor :id, :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| Users.new(datum) }
    end


    #looks up an id in a table and returns an object representing that row
    #returns a questions
    #contains a questions.new
    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          users
        WHERE
          id = ?
        SQL
        # "SELECT * FROM users WHERE id = #{id}")
        Users.new(data[0])
    end

    def self.find_by_name(fname, lname)
        data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT
          *
        FROM
          users
        WHERE
          fname = ? AND lname = ?
        SQL
            # "SELECT * FROM users WHERE fname = #{fname} AND lname = #{lname}")
        Users.new(data[0])
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        Questions.find_by_author_id(@id)
    end

    def authored_replies
        Replies.find_by_user_id(@id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(@id)
    end
end