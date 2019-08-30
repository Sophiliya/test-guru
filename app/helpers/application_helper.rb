module ApplicationHelper
  def footer_year
    Time.zone.now.year
  end

  def github_url(author, repo)
    content_tag :div do
      content_tag :a, author, href: repo, target: "_blank"
    end
  end
end
