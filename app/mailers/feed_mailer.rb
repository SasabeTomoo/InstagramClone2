class FeedMailer < ApplicationMailer
  def feed_mail(feed)
    @feed = feed
    mail to: @feed.email, subject: "投稿の確認メール"
  end
end
