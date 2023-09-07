require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "commande" do
    mail = OrderMailer.commande
    assert_equal "Commande", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
