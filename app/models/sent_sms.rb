class SentSms < ApplicationRecord
  validates :mobile, :sms_type, :status, presence: true

  def send
    self.status = TextlocalClient.send_otp(mobile, message_options['otp'])['status'] if mobile
    save
    # update status here
  end
end
