class NotifySpamBounceJob < ApplicationJob
  queue_as :default
  AVAIL_STATUS = %w[new notify_failed]

  def perform(email_bounce_id)
    email_bounce = EmailBounce.where(id: email_bounce_id, status: AVAIL_STATUS).first
    if email_bounce.nil?
      Rails.logger.warn { "No BounceEmail with id: #{email_bounce_id} was found" }
      return
    end

    email_bounce.update(status: "notifying")
    resp = slack_alert("email to: #{email_bounce.email} bounced as Spam at #{email_bounce.bounced_at.utc}")
    new_status = if resp.code == 200
      "notified"
    else
      "notify_failed"
    end
    email_bounce.update(status: new_status)
  end

  def slack_alert(text)
    resp = HTTP.auth("Bearer #{Rails.application.secrets[:slack][:bearer_token]}")
      .post("https://slack.com/api/chat.postMessage",
        form: {channel: Rails.application.secrets[:slack][:channel_id], text: "<!channel> #{text}"})
  end
end
