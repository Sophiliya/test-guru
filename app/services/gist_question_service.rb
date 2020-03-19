class GistQuestionService

  def initialize(question, client: nil)
    @question = question
    @test     = @question.test
    @client   = client || GitHubClient.new
  end

  def call
    @client.create_gist(gist_params)
  end

  def success?
    return unless @client.http_client.last_response

    @client.http_client.last_response.status == 201 ? true : false
  end

  private

  def gist_params
    {
      description: I18n.t('gists.create.message', test_title: @test.title),
      files: {
        "test-guru-question-#{@question.id}.txt" => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end