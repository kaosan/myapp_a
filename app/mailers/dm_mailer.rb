class DmMailer < ApplicationMailer
  def dm_mail(dm)
 @dm = dm

 mail to: "conversation.target_user(current_user).email", subject: "ダイレクトメッセージが届きました"
end
end
