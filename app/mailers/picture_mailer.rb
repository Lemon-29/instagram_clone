class ContactMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture
    mail to: @picture.user.email, subject: "Your enquiry has been sent!"
  end
end