# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/commande
  def commande
    @products = Order.last.order_products
    user = User.first

    OrderMailer.with(user: user).commande
  end

  def pdf_attachment_method(order_id)
    order = Order.find(order_id)
    attachments["todo_#{order.id}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: 'todo', template: 'order.pdf.erb', layout: 'pdf.html'), :hash_with_wickedpdf_options
    )
    mail(to: todo.owner.email, subject: 'Your order PDF is attached', todo: todo)
  end

end
