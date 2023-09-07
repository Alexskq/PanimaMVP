class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.commande.subject
  #
  def commande
    @order = Order.last
    attachments["orderTEST.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(template: 'order_mailer/commande', layout: 'pdf', pdf: 'orderTest')
    )

    mail(to: "simon.chretien62@gmail.com", subject: "Commande du #{Time.now}")
  end
end
