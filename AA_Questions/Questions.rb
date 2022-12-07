require_relative 'QuestionsDatabase'
require_relative 'QuestionFollow'
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
              # may need to return as an array in the future, stay tuned
    end

    def self.find_by_author_id(author_id)
      data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
      SQL

      data.map { |datum| Questions.new(datum) }
      # may need to return as an array in the future, stay tuned
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def author
      Users.find_by_id(@author_id)
    end

    def replies
      Replies.find_by_question_id(@id)
    end

    def followers
      QuestionFollow.followers_for_question_id(@id)
    end

    def self.most_followed(n)
      QuestionFollow.most_followed_questions(n)
    end
end