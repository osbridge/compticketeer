require 'rails_helper'

describe ApplicationMailer do
  CHARSET = 'utf-8'

  fixtures :users

  before :each do
    @ticket = create(:ticket)

    @email = TMail::Mail.new
    @email.set_content_type 'text', 'plain', { 'charset' => CHARSET }
    @email.mime_version = '1.0'
  end

  it "expects to not send ticket if ApplicationMailer is not configured" do
    ApplicationMailer.stub!(:configured? => false)

    expect(lambda { ApplicationMailer.ticket_email(@ticket).deliver_later }).to raise_error(ArgumentError)
  end

  it "expects to send ticket with a code if ApplicationMailer is configured" do
    stub_ticket_mailer_secrets

    expect(lambda { ApplicationMailer.ticket_email(@ticket).deliver_later }).to change(ActionMailer::Base.deliveries, :size).by(1)

    body = ActionMailer::Base.deliveries.last.body
    expect(body).to =~ /#{@ticket.discount_code}/
  end
end
