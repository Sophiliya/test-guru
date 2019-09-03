module ApplicationHelper
  def footer_year
    Time.zone.now.year
  end

  def github_url(author, repo)
    link_to author, repo, target: "_blank"
  end
end
