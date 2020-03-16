class GistQuestionService
  def initialize(question, client: nil)
    @question = question
    @test     = @question.test
    @client   = client || GitHubClient.new
  end

  def call
    gist = @client.create_gist(gist_params)

    if success?
      { success: true, gist_url: gist[:html_url] }
    else
      { success: false, errors: gist.errors }
    end
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

  def success?
    @client.http_client.last_response.status == 201 ? true : false
  end
end