require_relative 'QuestionsDatabase.rb'
require_relative 'users.rb'

class QuestionFollow
    def self.followers_for_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                users.id, fname, lname
            FROM
                users
            JOIN
                question_follows ON question_follows.user_id = users.id
            JOIN
                questions ON questions.id = question_follows.question_id
            WHERE
                question_id = ?
        SQL

        data.map{|datum| Users.new(datum)}
    end

    def self.followed_questions_for_user_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                questions.id, title, body, author_id
            FROM
                users
            JOIN
                question_follows ON question_follows.user_id = users.id
            JOIN
                questions ON questions.id = question_follows.question_id
            WHERE
                user_id = ?
        SQL

        data.map{|datum| Questions.new(datum)}
    end

    def self.most_followed_questions(n)
        
        data = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                id, title, body, author_id
            FROM
                questions
            JOIN
                question_follows ON question_follows.question_id = questions.id
            GROUP BY
                question_follows.question_id
            ORDER BY
                COUNT(question_follows.question_id) DESC
            LIMIT
                ?
        SQL

        data.map{|datum| Questions.new(datum)}
    end
end